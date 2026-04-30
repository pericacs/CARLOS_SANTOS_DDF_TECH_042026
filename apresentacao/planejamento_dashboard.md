# Planejamento do Dashboard - E-commerce Olist

## 1. Objetivo do Dashboard

O objetivo do dashboard é permitir que as áreas de negócio acompanhem a performance comercial, logística e de experiência do cliente da operação de e-commerce.

O dashboard será construído a partir das views da camada Gold:

```text
gold.vw_ecommerce_performance_comercial
gold.vw_ecommerce_experiencia_cliente
```

---

## 2. Público-Alvo

O dashboard foi pensado para apoiar:

- Diretoria comercial
- Time de operações
- Time de logística
- Time de atendimento ao cliente
- Time de produtos
- Analistas de dados e BI

---

## 3. Perguntas de Negócio

O dashboard deve responder às seguintes perguntas:

1. Como o faturamento evolui ao longo do tempo?
2. Quais estados concentram maior volume de pedidos?
3. Quais categorias geram maior faturamento?
4. Qual é o percentual de entregas atrasadas?
5. Qual é o ticket médio por período?
6. Quais categorias possuem pior avaliação média?
7. Existe relação entre atraso de entrega e review negativo?
8. Quais estados possuem maior risco de insatisfação?
9. Quais vendedores possuem maior volume de atrasos?
10. Quais produtos ou categorias merecem atenção operacional?

---

## 4. Indicadores Principais

### 4.1 KPIs Comerciais

| Indicador | Fórmula / Origem |
|---|---|
| Total de pedidos | `COUNT(DISTINCT order_id)` |
| Faturamento total | `SUM(faturamento_total)` |
| Faturamento produtos | `SUM(faturamento_produtos)` |
| Frete total | `SUM(valor_total_frete)` |
| Ticket médio | `AVG(ticket_medio)` |
| Total de itens vendidos | `SUM(total_itens)` |

---

### 4.2 KPIs Logísticos

| Indicador | Fórmula / Origem |
|---|---|
| Entregas atrasadas | `SUM(total_entregas_atrasadas)` |
| Percentual de atraso | `SUM(total_entregas_atrasadas) / COUNT(DISTINCT order_id)` |
| Média de dias até entrega | `AVG(media_dias_entrega)` |
| Média de dias de atraso | `AVG(media_dias_atraso)` |

---

### 4.3 KPIs de Experiência do Cliente

| Indicador | Fórmula / Origem |
|---|---|
| Nota média dos reviews | `AVG(review_score)` |
| Reviews negativos | `SUM(flag_review_negativo)` |
| Reviews positivos | `SUM(flag_review_positivo)` |
| Percentual de reviews negativos | `SUM(flag_review_negativo) / COUNT(review_id)` |
| Reviews com comentário | `SUM(flag_possui_comentario)` |

---

## 5. Visualizações Propostas

O case solicita pelo menos 5 visualizações diferentes. Para tornar a entrega mais forte, serão propostas 8 visualizações.

---

### 5.1 Evolução do Faturamento Mensal

**Tipo:** gráfico de linha  
**Fonte:** `gold.vw_ecommerce_performance_comercial`

**Objetivo:** acompanhar o crescimento ou queda do faturamento ao longo do tempo.

**Campos:**

- Eixo X: `ano`, `mes`
- Eixo Y: `SUM(faturamento_total)`

**Pergunta respondida:**

> Como o faturamento evoluiu ao longo dos meses?

---

### 5.2 Pedidos por Estado do Cliente

**Tipo:** gráfico de barras ou mapa  
**Fonte:** `gold.vw_ecommerce_performance_comercial`

**Objetivo:** identificar os estados com maior concentração de pedidos.

**Campos:**

- Dimensão: `estado_cliente`
- Métrica: `SUM(total_pedidos)`

**Pergunta respondida:**

> Quais estados possuem maior volume de pedidos?

---

### 5.3 Faturamento por Categoria de Produto

**Tipo:** gráfico de barras horizontais  
**Fonte:** `gold.vw_ecommerce_performance_comercial`

**Objetivo:** identificar categorias de maior impacto comercial.

**Campos:**

- Dimensão: `product_category_name_english`
- Métrica: `SUM(faturamento_total)`

**Pergunta respondida:**

> Quais categorias geram maior faturamento?

---

### 5.4 Percentual de Entregas Atrasadas

**Tipo:** indicador/KPI  
**Fonte:** `gold.vw_ecommerce_performance_comercial`

**Objetivo:** medir o percentual de pedidos entregues fora do prazo.

**Campos:**

- Métrica: `AVG(percentual_entregas_atrasadas)`

**Pergunta respondida:**

> Qual percentual dos pedidos foi entregue com atraso?

---

### 5.5 Ticket Médio Mensal

**Tipo:** gráfico de linha ou cartão KPI  
**Fonte:** `gold.vw_ecommerce_performance_comercial`

**Objetivo:** acompanhar a evolução do valor médio dos pedidos.

**Campos:**

- Eixo X: `ano`, `mes`
- Eixo Y: `AVG(ticket_medio)`

**Pergunta respondida:**

> O ticket médio está aumentando ou diminuindo ao longo do tempo?

---

### 5.6 Nota Média por Categoria

**Tipo:** gráfico de barras  
**Fonte:** `gold.vw_ecommerce_experiencia_cliente`

**Objetivo:** identificar categorias com melhor e pior satisfação.

**Campos:**

- Dimensão: `product_category_name_english`
- Métrica: `AVG(review_score)`

**Pergunta respondida:**

> Quais categorias possuem pior avaliação média?

---

### 5.7 Relação entre Atraso e Review

**Tipo:** gráfico de barras empilhadas  
**Fonte:** `gold.vw_ecommerce_experiencia_cliente`

**Objetivo:** avaliar se entregas atrasadas impactam negativamente a experiência do cliente.

**Campos:**

- Dimensão: `categoria_experiencia`
- Métrica: `COUNT(review_id)`

**Pergunta respondida:**

> Existe relação entre atraso de entrega e review negativo?

---

### 5.8 Risco de Insatisfação por Estado

**Tipo:** gráfico de barras ou mapa  
**Fonte:** `gold.vw_ecommerce_experiencia_cliente`

**Objetivo:** identificar regiões com maior concentração de clientes insatisfeitos.

**Campos:**

- Dimensão: `estado_cliente`
- Métrica: `COUNT(review_id)`
- Filtro: `risco_insatisfacao = 'Alto'`

**Pergunta respondida:**

> Quais estados concentram maior risco de insatisfação?

---

## 6. Filtros Recomendados

O dashboard deve possuir filtros para permitir exploração dos dados:

| Filtro | Campo |
|---|---|
| Período | `ano`, `mes`, `data_compra`, `data_review` |
| Estado do cliente | `estado_cliente` |
| Categoria do produto | `product_category_name_english` |
| Estado do vendedor | `estado_vendedor` |
| Status do pedido | `order_status` |
| Classificação do review | `classificacao_review` |
| Risco de insatisfação | `risco_insatisfacao` |

---

## 7. Estrutura Recomendada do Dashboard

### Página 1 - Visão Executiva

Indicadores principais:

- Faturamento total
- Total de pedidos
- Ticket médio
- Percentual de atraso
- Nota média dos reviews

Visualizações:

- Evolução do faturamento mensal
- Pedidos por estado
- Faturamento por categoria

---

### Página 2 - Logística e Entregas

Indicadores principais:

- Total de entregas atrasadas
- Percentual de atraso
- Média de dias até entrega
- Média de dias de atraso

Visualizações:

- Atrasos por estado
- Atrasos por vendedor
- Atrasos por categoria

---

### Página 3 - Experiência do Cliente

Indicadores principais:

- Nota média
- Reviews negativos
- Reviews positivos
- Percentual de reviews negativos
- Reviews com comentário

Visualizações:

- Nota média por categoria
- Relação entre atraso e review
- Risco de insatisfação por estado

---

## 8. Evidências Esperadas

Após criar o dashboard na Dadosfera, devem ser salvas evidências em:

```text
evidencias/dashboard/
```

Sugestão de prints:

```text
evidencias/dashboard/dashboard_visao_executiva.png
evidencias/dashboard/dashboard_logistica.png
evidencias/dashboard/dashboard_experiencia_cliente.png
```

---

## 9. Link do Dashboard

Após a criação do dashboard na Dadosfera, incluir o link abaixo:

```text
Link: Pendente
```

---

## 10. Conclusão

O dashboard proposto permite transformar os dados tratados e modelados da Olist em informações acionáveis para o negócio.

A solução apoia decisões comerciais, logísticas e de relacionamento com o cliente, demonstrando como a Dadosfera pode reduzir o tempo entre a coleta dos dados e a geração de valor analítico.