USE hotel_nebula;

-- 1. Quartos disponíveis para todo o período [entrada, saída).
-- A saída de uma reserva pode ser a entrada da próxima.
SET @entrada = '2026-11-10';
SET @saida = '2026-11-12';
SELECT u.nome AS unidade, q.numero, q.tipo, q.capacidade, q.preco_diaria
FROM quartos q JOIN unidades u ON u.id_unidade = q.id_unidade
WHERE q.status = 'DISPONIVEL' AND @saida > @entrada
AND NOT EXISTS (
  SELECT 1 FROM reservas r WHERE r.id_quarto = q.id_quarto
  AND r.status IN ('PENDENTE', 'CONFIRMADA', 'CONCLUIDA')
  AND r.data_checkin < @saida AND r.data_checkout > @entrada
)
ORDER BY u.id_unidade, q.numero;

-- 2. Ranking de hóspedes por reservas não canceladas (inclui pendentes).
SELECT h.id_hospede, h.nome, COUNT(r.id_reserva) AS total_reservas
FROM hospedes h LEFT JOIN reservas r
  ON r.id_hospede = h.id_hospede AND r.status <> 'CANCELADA'
GROUP BY h.id_hospede, h.nome
ORDER BY total_reservas DESC, h.id_hospede;

-- 3. Faturamento: recebimentos confirmados por mês do pagamento, em BRL.
-- Não soma pagamentos pendentes, falhos ou integralmente estornados.
SELECT YEAR(data_pagamento) AS ano, MONTH(data_pagamento) AS mes,
       SUM(valor) AS total_recebido_brl
FROM pagamentos WHERE status = 'CONFIRMADO'
GROUP BY YEAR(data_pagamento), MONTH(data_pagamento) ORDER BY ano, mes;

-- 4. Serviços mais consumidos, incluindo os que ainda não tiveram consumo.
SELECT s.nome, COALESCE(SUM(hs.quantidade), 0) AS quantidade_consumida,
       COALESCE(SUM(hs.quantidade * hs.preco_unitario), 0) AS valor_consumido_brl
FROM servicos s LEFT JOIN hospedagem_servicos hs ON hs.id_servico = s.id_servico
GROUP BY s.id_servico, s.nome ORDER BY quantidade_consumida DESC, s.id_servico;

-- 5. Ranking de quartos por nota média. Quartos sem avaliação ficam fora.
SELECT u.nome AS unidade, q.numero, COUNT(f.id_feedback) AS avaliacoes,
       ROUND(AVG(f.nota), 2) AS nota_media
FROM feedbacks f JOIN hospedagens hp ON hp.id_hospedagem = f.id_hospedagem
JOIN reservas r ON r.id_reserva = hp.id_reserva
JOIN quartos q ON q.id_quarto = r.id_quarto
JOIN unidades u ON u.id_unidade = q.id_unidade
GROUP BY u.id_unidade, u.nome, q.id_quarto, q.numero
ORDER BY nota_media DESC, avaliacoes DESC, q.id_quarto;

-- 6. Reservas canceladas, preservadas para consulta do histórico.
SELECT r.id_reserva, h.nome AS hospede, u.nome AS unidade, q.numero,
       r.data_checkin, r.data_checkout, r.motivo_cancelamento
FROM reservas r JOIN hospedes h ON h.id_hospede = r.id_hospede
JOIN quartos q ON q.id_quarto = r.id_quarto
JOIN unidades u ON u.id_unidade = q.id_unidade
WHERE r.status = 'CANCELADA' ORDER BY r.id_reserva;

-- 7. Hospedagens distintas atendidas por profissional, inclusive zero.
SELECT f.id_funcionario, f.nome, f.cargo,
       COUNT(DISTINCT hf.id_hospedagem) AS hospedagens_atendidas
FROM funcionarios f LEFT JOIN hospedagem_funcionarios hf
  ON hf.id_funcionario = f.id_funcionario
GROUP BY f.id_funcionario, f.nome, f.cargo
ORDER BY hospedagens_atendidas DESC, f.id_funcionario;
