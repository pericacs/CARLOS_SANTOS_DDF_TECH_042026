# Camada Gold - Modelagem Dimensional

## Objetivo

Esta pasta contém os scripts SQL responsáveis pela criação da camada Gold do projeto.

A camada Gold representa os dados organizados em modelo dimensional, seguindo os princípios de Kimball, com tabelas dimensão e tabelas fato preparadas para consumo analítico.

---

## Tabelas Criadas

| Arquivo | Tabela | Descrição |
|---|---|---|
| `dim_cliente.sql` | `gold.dim_cliente` | Dimensão de clientes |
| `dim_produto.sql` | `gold.dim_produto` | Dimensão de produtos |
| `dim_vendedor.sql` | `gold.dim_vendedor` | Dimensão de vendedores |
| `dim_tempo.sql` | `gold.dim_tempo` | Dimensão calendário |
| `fato_pedidos.sql` | `gold.fato_pedidos` | Fato principal de pedidos, vendas e entregas |

---

## Modelo Proposto

```text
                dim_cliente
                     |
                     |
dim_tempo ---- fato_pedidos ---- dim_produto
                     |
                     |
                dim_vendedor