-- Dados fictícios para uma base recém-criada. Execute uma única vez.
USE hotel_nebula;
START TRANSACTION;

INSERT INTO unidades (id_unidade, nome, cidade, estado, endereco) VALUES
(1, 'Nebula Paulista', 'São Paulo', 'SP', 'Rua das Estrelas, 100'),
(2, 'Nebula Atlântico', 'Rio de Janeiro', 'RJ', 'Avenida da Lua, 200');

INSERT INTO hospedes (id_hospede, nome, email, telefone, nacionalidade) VALUES
(1, 'Ana Silva', 'ana@example.com', '11900000001', 'Brasileira'),
(2, 'Bruno Costa', 'bruno@example.com', '21900000002', 'Brasileira'),
(3, 'Carla Souza', 'carla@example.com', '11900000003', 'Brasileira'),
(4, 'Diego Lima', 'diego@example.com', '21900000004', 'Brasileira'),
(5, 'Elisa Santos', 'elisa@example.com', '11900000005', 'Brasileira'),
(6, 'Felipe Alves', 'felipe@example.com', '31900000006', 'Brasileira');

INSERT INTO quartos (id_quarto, id_unidade, numero, tipo, capacidade, preco_diaria, status) VALUES
(1, 1, '101', 'Casal', 2, 280.00, 'DISPONIVEL'),
(2, 1, '102', 'Solteiro', 1, 180.00, 'DISPONIVEL'),
(3, 1, '201', 'Suíte', 3, 450.00, 'DISPONIVEL'),
(4, 2, '101', 'Duplo', 2, 320.00, 'DISPONIVEL'),
(5, 2, '102', 'Duplo', 2, 320.00, 'MANUTENCAO');

INSERT INTO funcionarios (id_funcionario, nome, cargo, email, data_admissao) VALUES
(1, 'Clara Martins', 'Recepcionista', 'clara@example.com', '2025-01-10'),
(2, 'Rafael Melo', 'Concierge', 'rafael@example.com', '2025-02-15'),
(3, 'Camila Rocha', 'Gerente de hospedagem', 'camila@example.com', '2024-06-01'),
(4, 'Lucas Nunes', 'Recepcionista', 'lucas@example.com', '2026-10-01');

INSERT INTO reservas
(id_reserva, id_hospede, id_quarto, data_checkin, data_checkout, quantidade_hospedes, valor_diaria, status, data_reserva, motivo_cancelamento) VALUES
(1, 1, 1, '2026-09-01', '2026-09-04', 2, 280.00, 'CONCLUIDA', '2026-08-22 10:00:00', NULL),
(2, 2, 2, '2026-09-02', '2026-09-04', 1, 180.00, 'CONCLUIDA', '2026-08-23 10:00:00', NULL),
(3, 1, 3, '2026-10-05', '2026-10-08', 2, 450.00, 'CONCLUIDA', '2026-09-25 10:00:00', NULL),
(4, 3, 1, '2026-11-10', '2026-11-13', 2, 280.00, 'CONFIRMADA', '2026-10-31 10:00:00', NULL),
(5, 4, 2, '2026-11-11', '2026-11-13', 1, 180.00, 'CANCELADA', '2026-11-01 10:00:00', 'Mudança na viagem'),
(6, 2, 4, '2026-10-15', '2026-10-18', 2, 320.00, 'CONCLUIDA', '2026-10-05 10:00:00', NULL),
(7, 5, 2, '2026-11-10', '2026-11-12', 1, 180.00, 'CONFIRMADA', '2026-10-31 10:00:00', NULL),
(8, 3, 3, '2026-09-20', '2026-09-22', 2, 450.00, 'CONCLUIDA', '2026-09-10 10:00:00', NULL),
(9, 1, 1, '2026-12-01', '2026-12-04', 2, 280.00, 'PENDENTE', '2026-11-21 10:00:00', NULL),
(10, 6, 1, '2026-09-04', '2026-09-06', 1, 280.00, 'CONCLUIDA', '2026-08-25 10:00:00', NULL),
(11, 4, 4, '2026-11-07', '2026-11-10', 2, 320.00, 'CONFIRMADA', '2026-10-28 10:00:00', NULL);

INSERT INTO hospedagens (id_hospedagem, id_reserva, checkin_real, checkout_real, status) VALUES
(1, 1, '2026-09-01 14:00:00', '2026-09-04 11:00:00', 'FINALIZADA'),
(2, 2, '2026-09-02 14:30:00', '2026-09-04 11:30:00', 'FINALIZADA'),
(3, 3, '2026-10-05 15:00:00', '2026-10-08 10:00:00', 'FINALIZADA'),
(4, 6, '2026-10-15 14:00:00', '2026-10-18 11:00:00', 'FINALIZADA'),
(5, 8, '2026-09-20 14:00:00', '2026-09-22 11:00:00', 'FINALIZADA'),
(6, 10, '2026-09-04 14:00:00', '2026-09-06 11:00:00', 'FINALIZADA'),
(7, 11, '2026-11-07 14:00:00', NULL, 'EM_ANDAMENTO');

INSERT INTO servicos (id_servico, nome, descricao, preco_atual) VALUES
(1, 'Café da manhã', 'Uma porção individual', 35.00),
(2, 'Traslado', 'Uma viagem ao aeroporto', 120.00),
(3, 'Lavanderia', 'Um pacote de lavagem', 50.00),
(4, 'Minibar', 'Um kit de bebidas', 30.00),
(5, 'Estacionamento', 'Uma diária de estacionamento', 40.00);

INSERT INTO hospedagem_servicos
(id_consumo, id_hospedagem, id_servico, quantidade, preco_unitario, data_consumo) VALUES
(1, 1, 1, 2, 35.00, '2026-09-02 08:00:00'),
(2, 1, 2, 1, 120.00, '2026-09-04 11:00:00'),
(3, 2, 4, 1, 30.00, '2026-09-03 20:00:00'),
(4, 3, 1, 3, 35.00, '2026-10-06 08:00:00'),
(5, 3, 4, 1, 30.00, '2026-10-07 20:00:00'),
(6, 4, 3, 1, 50.00, '2026-10-16 10:00:00'),
(7, 5, 1, 2, 35.00, '2026-09-21 08:00:00');

INSERT INTO pagamentos
(id_pagamento, id_hospedagem, valor, metodo, status, data_pagamento, referencia) VALUES
(1, 1, 600.00, 'PIX', 'CONFIRMADO', '2026-09-01 14:00:00', 'PAG-001'),
(2, 1, 430.00, 'CARTAO', 'CONFIRMADO', '2026-09-04 11:00:00', 'PAG-002'),
(3, 2, 390.00, 'PIX', 'CONFIRMADO', '2026-09-04 11:30:00', 'PAG-003'),
(4, 3, 1000.00, 'CARTAO', 'CONFIRMADO', '2026-10-05 15:00:00', 'PAG-004'),
(5, 3, 485.00, 'PIX', 'CONFIRMADO', '2026-10-08 10:00:00', 'PAG-005'),
(6, 4, 1010.00, 'TRANSFERENCIA', 'CONFIRMADO', '2026-10-18 11:00:00', 'PAG-006'),
(7, 5, 970.00, 'CARTAO', 'CONFIRMADO', '2026-09-22 11:00:00', 'PAG-007'),
(8, 6, 560.00, 'DINHEIRO', 'CONFIRMADO', '2026-09-06 11:00:00', 'PAG-008'),
(9, 7, 960.00, 'PIX', 'PENDENTE', NULL, 'PAG-009'),
(10, 7, 100.00, 'CARTAO', 'FALHOU', NULL, 'PAG-010');

INSERT INTO hospedagem_funcionarios (id_hospedagem, id_funcionario, funcao_atendimento) VALUES
(1, 1, 'Check-in'), (1, 2, 'Suporte ao hóspede'),
(2, 1, 'Check-in e check-out'), (3, 2, 'Check-in e check-out'),
(4, 3, 'Supervisão'), (5, 1, 'Check-in'), (5, 3, 'Supervisão'),
(6, 2, 'Check-in e check-out'), (7, 3, 'Check-in');

INSERT INTO feedbacks (id_feedback, id_hospedagem, nota, comentario, data_feedback) VALUES
(1, 1, 5, 'Quarto confortável e equipe atenciosa.', '2026-09-04 15:00:00'),
(2, 2, 4, 'Boa estadia.', '2026-09-04 16:00:00'),
(3, 3, 5, 'Suíte muito agradável.', '2026-10-08 15:00:00'),
(4, 4, 4, 'Bom atendimento.', '2026-10-18 16:00:00'),
(5, 5, 3, 'A limpeza pode melhorar.', '2026-09-22 15:00:00'),
(6, 6, 4, 'Voltaria ao hotel.', '2026-09-06 15:00:00');

UPDATE hospedes SET data_cadastro = '2026-01-01 10:00:00';

COMMIT;
