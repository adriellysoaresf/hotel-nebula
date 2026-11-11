-- Procedimento complementar: cria reservas sem sobreposição entre chamadas.
-- Execute uma vez após 01_estrutura.sql. Chame fora de outra transação.
-- Toda criação concorrente deve passar por este procedimento.
USE hotel_nebula;
DELIMITER $$
CREATE PROCEDURE registrar_reserva (
  IN p_id_hospede INT,
  IN p_id_quarto INT,
  IN p_entrada DATE,
  IN p_saida DATE,
  IN p_quantidade INT
)
BEGIN
  DECLARE v_capacidade INT DEFAULT NULL;
  DECLARE v_preco DECIMAL(10,2);
  DECLARE v_status VARCHAR(20);
  DECLARE v_conflitos INT DEFAULT 0;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  START TRANSACTION;
  IF p_entrada IS NULL OR p_saida IS NULL OR p_saida <= p_entrada
     OR p_quantidade IS NULL OR p_quantidade <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Periodo ou quantidade de hospedes invalido';
  END IF;

  -- A trava do quarto serializa reservas concorrentes para o mesmo quarto.
  SELECT capacidade, preco_diaria, status INTO v_capacidade, v_preco, v_status
  FROM quartos WHERE id_quarto = p_id_quarto FOR UPDATE;

  IF v_capacidade IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quarto inexistente';
  END IF;
  IF v_status <> 'DISPONIVEL' OR p_quantidade > v_capacidade THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quarto indisponivel ou capacidade excedida';
  END IF;

  SELECT COUNT(*) INTO v_conflitos FROM reservas
  WHERE id_quarto = p_id_quarto AND status <> 'CANCELADA'
    AND data_checkin < p_saida AND data_checkout > p_entrada;
  IF v_conflitos > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quarto ja reservado no periodo';
  END IF;

  INSERT INTO reservas
  (id_hospede, id_quarto, data_checkin, data_checkout,
   quantidade_hospedes, valor_diaria, status)
  VALUES
  (p_id_hospede, p_id_quarto, p_entrada, p_saida,
   p_quantidade, v_preco, 'CONFIRMADA');
  COMMIT;
  SELECT LAST_INSERT_ID() AS id_reserva_criada;
END$$
DELIMITER ;

-- Exemplos (comentados para não alterar os resultados dos dados iniciais):
-- CALL registrar_reserva(1, 3, '2026-11-10', '2026-11-12', 2); -- aceita
-- CALL registrar_reserva(1, 1, '2026-11-11', '2026-11-12', 2); -- conflito
