<div align="center">

# ✦ Hotel Nebula

### Modelagem, organização e consultas.ᐟ

Projeto desenvolvido durante meus estudos de **Banco de Dados Relacional**, com foco na organização de uma rede hoteleira.

<br>

<img src="https://skillicons.dev/icons?i=mysql" alt="MySQL"/>

</div>

<br>

## ✦ Sobre o projeto

O Hotel Nebula precisa organizar informações sobre hóspedes, quartos, reservas, hospedagens, pagamentos, profissionais, serviços e avaliações.

A proposta é percorrer a modelagem, a implementação física e a criação de consultas para apoiar a gestão, preparando os dados para uma futura API.

## ✦ Entregas

| Parte | Conteúdo | Arquivo |
|---|---|---|
| 1 — Origem do Sistema | Diagramas ER, entidades, relacionamentos, regras e modelo lógico | [Modelagem](./modelagem.md) |
| 2 — Montagem do Núcleo | Banco, tabelas, chaves, restrições e índices | [Estrutura SQL](./01_estrutura.sql) |
| 2 — Montagem do Núcleo | Dados fictícios para testes | [Dados iniciais](./02_dados.sql) |
| 2 — Complemento | Criação de reservas com verificação de capacidade e conflito de datas | [Reservas seguras](./04_reservas_seguras.sql) |
| 3 — Radar de Comando | Sete consultas para gestão | [Consultas SQL](./03_consultas.sql) |
| 3 — Conferência | Resultados esperados com os dados iniciais | [Resultados](./resultados.md) |

## ✦ Como executar

No MySQL 8.0.16+ com InnoDB, abra uma conexão e execute uma vez, em ordem:

1. `01_estrutura.sql`
2. `02_dados.sql`
3. `04_reservas_seguras.sql`
4. `03_consultas.sql`

Os scripts usam o banco `hotel_nebula`, que deve estar vazio na primeira execução. Não há comandos para apagar bancos ou tabelas. O usuário da conexão precisa ter permissão para criar banco, tabelas e procedimento.

Na primeira consulta, altere `@entrada` e `@saida` para pesquisar outro período. Os exemplos de `CALL` estão comentados para preservar os resultados iniciais.

## ✦ Conteúdos praticados

`Modelo ER` • `Chaves primárias e estrangeiras` • `Relacionamentos N:N` • `Restrições` • `JOIN` • `Agregações` • `Subconsultas` • `Transações`

## ✦ Verificação

As sete consultas, os dados e as restrições foram conferidos em SQLite, adaptando apenas a sintaxe específica de MySQL. Foram verificados relacionamentos, valores inválidos, períodos, limites de notas e a conciliação dos pagamentos das hospedagens finalizadas.

**A execução nativa em MySQL e o procedimento de reservas, incluindo concorrência, ainda precisam ser testados nesse ambiente.** As regras que dependem da futura aplicação estão identificadas na documentação.

## ✦ Tecnologias e ferramentas

<div align="center">

<img src="https://skillicons.dev/icons?i=mysql,github" alt="MySQL e GitHub"/>

</div>

<br>

---

<div align="center">

Feito por [Adrielly Soares](https://github.com/adriellysoaresf)

</div>
