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
| `fato_pagamentos.sql` | `gold.fato_pagamentos` | Fato de pagamentos dos pedidos |
| `fato_reviews.sql` | `gold.fato_reviews` | Fato de avaliações e satisfação dos clientes |
| `vw_ecommerce_performance_comercial.sql` | `gold.vw_ecommerce_performance_comercial` | Visão consolidada para dashboard comercial |
| `vw_ecommerce_experiencia_cliente.sql` | `gold.vw_ecommerce_experiencia_cliente` | Visão consolidada para análise de satisfação, reviews e atrasos |

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

```
---

## Visões Analíticas

### `gold.vw_ecommerce_performance_comercial`

Esta view consolida informações de pedidos, clientes, produtos, vendedores e tempo.

Ela será utilizada para criação de indicadores como:

- faturamento por mês;
- pedidos por estado;
- faturamento por categoria;
- ticket médio;
- percentual de entregas atrasadas;
- média de dias até entrega;
- performance por vendedor;
- performance por categoria.                

---

### `gold.vw_ecommerce_experiencia_cliente`

Esta view consolida dados de reviews, pedidos, entregas, clientes, produtos e vendedores.

Ela será utilizada para análises como:

- score médio de avaliação;
- percentual de reviews negativos;
- reviews por categoria de produto;
- relação entre atraso e avaliação;
- risco de insatisfação do cliente;
- comentários de clientes para uso com IA;
- categorias com maior impacto negativo na experiência do cliente.
