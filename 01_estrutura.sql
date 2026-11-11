-- Hotel Nebula | MySQL 8.0.16+ (CHECK aplicado a partir desta versão).
-- Use um schema novo. Este script não apaga bancos nem tabelas.
CREATE DATABASE IF NOT EXISTS hotel_nebula
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hotel_nebula;

CREATE TABLE unidades (
  id_unidade INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  cidade VARCHAR(80) NOT NULL,
  estado CHAR(2) NOT NULL,
  endereco VARCHAR(180) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE hospedes (
  id_hospede INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  cpf VARCHAR(14) UNIQUE,
  telefone VARCHAR(20),
  data_nascimento DATE,
  nacionalidade VARCHAR(60),
  data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

CREATE TABLE quartos (
  id_quarto INT PRIMARY KEY AUTO_INCREMENT,
  id_unidade INT NOT NULL,
  numero VARCHAR(10) NOT NULL,
  tipo VARCHAR(50) NOT NULL,
  capacidade INT NOT NULL,
  preco_diaria DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'DISPONIVEL',
  descricao VARCHAR(255),
  CONSTRAINT uq_numero_unidade UNIQUE (id_unidade, numero),
  CONSTRAINT fk_quarto_unidade FOREIGN KEY (id_unidade)
    REFERENCES unidades(id_unidade),
  CONSTRAINT ck_quarto_capacidade CHECK (capacidade > 0),
  CONSTRAINT ck_quarto_diaria CHECK (preco_diaria > 0),
  CONSTRAINT ck_quarto_status CHECK (status IN ('DISPONIVEL', 'MANUTENCAO', 'INATIVO'))
) ENGINE = InnoDB;

CREATE TABLE funcionarios (
  id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  telefone VARCHAR(20),
  data_admissao DATE NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT ck_funcionario_ativo CHECK (ativo IN (0, 1))
) ENGINE = InnoDB;

CREATE TABLE reservas (
  id_reserva INT PRIMARY KEY AUTO_INCREMENT,
  id_hospede INT NOT NULL,
  id_quarto INT NOT NULL,
  data_checkin DATE NOT NULL,
  data_checkout DATE NOT NULL,
  quantidade_hospedes INT NOT NULL DEFAULT 1,
  valor_diaria DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
  data_reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  motivo_cancelamento VARCHAR(255),
  observacoes VARCHAR(255),
  CONSTRAINT fk_reserva_hospede FOREIGN KEY (id_hospede)
    REFERENCES hospedes(id_hospede),
  CONSTRAINT fk_reserva_quarto FOREIGN KEY (id_quarto)
    REFERENCES quartos(id_quarto),
  CONSTRAINT ck_reserva_periodo CHECK (data_checkout > data_checkin),
  CONSTRAINT ck_reserva_quantidade CHECK (quantidade_hospedes > 0),
  CONSTRAINT ck_reserva_diaria CHECK (valor_diaria > 0),
  CONSTRAINT ck_reserva_status CHECK (status IN ('PENDENTE', 'CONFIRMADA', 'CANCELADA', 'CONCLUIDA'))
) ENGINE = InnoDB;
CREATE INDEX idx_reserva_disponibilidade
  ON reservas (id_quarto, status, data_checkin, data_checkout);

CREATE TABLE hospedagens (
  id_hospedagem INT PRIMARY KEY AUTO_INCREMENT,
  id_reserva INT NOT NULL UNIQUE,
  checkin_real DATETIME NOT NULL,
  checkout_real DATETIME,
  status VARCHAR(20) NOT NULL DEFAULT 'EM_ANDAMENTO',
  CONSTRAINT fk_hospedagem_reserva FOREIGN KEY (id_reserva)
    REFERENCES reservas(id_reserva),
  CONSTRAINT ck_hospedagem_datas CHECK (checkout_real IS NULL OR checkout_real > checkin_real),
  CONSTRAINT ck_hospedagem_status CHECK (
    (status = 'EM_ANDAMENTO' AND checkout_real IS NULL)
    OR (status = 'FINALIZADA' AND checkout_real IS NOT NULL)
  )
) ENGINE = InnoDB;

CREATE TABLE pagamentos (
  id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
  id_hospedagem INT NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  metodo VARCHAR(30) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
  data_pagamento DATETIME,
  referencia VARCHAR(60) NOT NULL UNIQUE,
  CONSTRAINT fk_pagamento_hospedagem FOREIGN KEY (id_hospedagem)
    REFERENCES hospedagens(id_hospedagem),
  CONSTRAINT ck_pagamento_valor CHECK (valor > 0),
  CONSTRAINT ck_pagamento_metodo CHECK (metodo IN ('PIX', 'CARTAO', 'DINHEIRO', 'TRANSFERENCIA')),
  CONSTRAINT ck_pagamento_status CHECK (status IN ('PENDENTE', 'CONFIRMADO', 'FALHOU', 'ESTORNADO')),
  CONSTRAINT ck_pagamento_data CHECK (status NOT IN ('CONFIRMADO', 'ESTORNADO') OR data_pagamento IS NOT NULL)
) ENGINE = InnoDB;

CREATE TABLE servicos (
  id_servico INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(80) NOT NULL UNIQUE,
  descricao VARCHAR(255),
  preco_atual DECIMAL(10,2) NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT ck_servico_preco CHECK (preco_atual >= 0),
  CONSTRAINT ck_servico_ativo CHECK (ativo IN (0, 1))
) ENGINE = InnoDB;

CREATE TABLE hospedagem_servicos (
  id_consumo INT PRIMARY KEY AUTO_INCREMENT,
  id_hospedagem INT NOT NULL,
  id_servico INT NOT NULL,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  data_consumo DATETIME NOT NULL,
  CONSTRAINT fk_consumo_hospedagem FOREIGN KEY (id_hospedagem)
    REFERENCES hospedagens(id_hospedagem),
  CONSTRAINT fk_consumo_servico FOREIGN KEY (id_servico)
    REFERENCES servicos(id_servico),
  CONSTRAINT ck_consumo_quantidade CHECK (quantidade > 0),
  CONSTRAINT ck_consumo_preco CHECK (preco_unitario >= 0)
) ENGINE = InnoDB;

CREATE TABLE hospedagem_funcionarios (
  id_hospedagem INT NOT NULL,
  id_funcionario INT NOT NULL,
  funcao_atendimento VARCHAR(60) NOT NULL,
  PRIMARY KEY (id_hospedagem, id_funcionario),
  CONSTRAINT fk_atendimento_hospedagem FOREIGN KEY (id_hospedagem)
    REFERENCES hospedagens(id_hospedagem),
  CONSTRAINT fk_atendimento_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES funcionarios(id_funcionario)
) ENGINE = InnoDB;

CREATE TABLE feedbacks (
  id_feedback INT PRIMARY KEY AUTO_INCREMENT,
  id_hospedagem INT NOT NULL UNIQUE,
  nota INT NOT NULL,
  comentario VARCHAR(500),
  data_feedback DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_feedback_hospedagem FOREIGN KEY (id_hospedagem)
    REFERENCES hospedagens(id_hospedagem),
  CONSTRAINT ck_feedback_nota CHECK (nota BETWEEN 1 AND 5)
) ENGINE = InnoDB;
