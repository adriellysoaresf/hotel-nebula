# ✦ Parte 3 — Radar de Comando

Resultados esperados após executar os dados iniciais, antes de cadastrar novas reservas. As sete consultas estão em [03_consultas.sql](./03_consultas.sql).

## 1. Quartos disponíveis de 10 a 12/11/2026

| Unidade | Quarto | Tipo | Capacidade | Diária (R$) |
| --- | --- | --- | --- | --- |
| Nebula Paulista | 201 | Suíte | 3 | 450,00 |
| Nebula Atlântico | 101 | Duplo | 2 | 320,00 |

O quarto 102 do Nebula Atlântico está em manutenção e não aparece. Reservas canceladas não bloqueiam datas; check-out e novo check-in no mesmo dia são permitidos.

## 2. Hóspedes com mais reservas não canceladas

| ID | Hóspede | Reservas |
| --- | --- | --- |
| 1 | Ana Silva | 3 |
| 2 | Bruno Costa | 2 |
| 3 | Carla Souza | 2 |
| 4 | Diego Lima | 1 |
| 5 | Elisa Santos | 1 |
| 6 | Felipe Alves | 1 |

## 3. Recebimentos confirmados por mês

| Ano | Mês | Recebido (R$) |
| --- | --- | --- |
| 2026 | 9 | 2.950,00 |
| 2026 | 10 | 2.495,00 |

Pagamentos pendentes e falhos não entram na soma. O total confirmado é **R$ 5.445,00**. O critério é recebimento por data de pagamento, não previsão de receita das reservas.

## 4. Serviços extras mais consumidos

| Serviço | Quantidade | Valor consumido (R$) |
| --- | --- | --- |
| Café da manhã | 7 | 245,00 |
| Minibar | 2 | 60,00 |
| Traslado | 1 | 120,00 |
| Lavanderia | 1 | 50,00 |
| Estacionamento | 0 | 0,00 |

## 5. Quartos com melhores avaliações

| Unidade | Quarto | Avaliações | Média |
| --- | --- | --- | --- |
| Nebula Paulista | 101 | 2 | 4,50 |
| Nebula Paulista | 201 | 2 | 4,00 |
| Nebula Paulista | 102 | 1 | 4,00 |
| Nebula Atlântico | 101 | 1 | 4,00 |

A quantidade de avaliações acompanha a média para dar contexto ao ranking.

## 6. Reservas canceladas

| Reserva | Hóspede | Unidade | Quarto | Entrada | Saída | Motivo |
| --- | --- | --- | --- | --- | --- | --- |
| 5 | Diego Lima | Nebula Paulista | 102 | 2026-11-11 | 2026-11-13 | Mudança na viagem |

## 7. Hospedagens atendidas por profissional

| ID | Nome | Cargo | Hospedagens |
| --- | --- | --- | --- |
| 1 | Clara Martins | Recepcionista | 3 |
| 2 | Rafael Melo | Concierge | 3 |
| 3 | Camila Rocha | Gerente de hospedagem | 3 |
| 4 | Lucas Nunes | Recepcionista | 0 |
