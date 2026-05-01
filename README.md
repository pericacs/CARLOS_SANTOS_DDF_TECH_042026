# CARLOS_SANTOS_DDF_TECH_042026

## Case Técnico Dadosfera

Autor: Carlos André Cardoso dos Santos  
Mês/Ano: 04/2026  
Tema: Plataforma de Dados para E-commerce com Análise de Vendas, Entregas, Satisfação de Clientes e IA aplicada a Reviews

---

## 1. Visão Geral do Projeto

Este projeto tem como objetivo construir uma prova de conceito de uma Plataforma de Dados para uma empresa de e-commerce, utilizando a Dadosfera como plataforma central para integração, catalogação, qualidade, processamento, análise, visualização e geração de valor com IA.

A proposta é demonstrar como dados transacionais e desestruturados podem ser centralizados, tratados, modelados e disponibilizados para áreas de negócio com maior agilidade, menor custo operacional e melhor governança.

O case contempla as seguintes etapas:

- Planejamento do projeto
- Escolha e carga da base de dados
- Organização dos dados em camadas de Data Lake
- Catalogação e dicionário de dados
- Data Quality com Great Expectations
- Uso de GenAI/LLM para extração de features de textos
- Modelagem dimensional seguindo Kimball
- Dashboard analítico
- Pipeline de processamento
- Data App em Streamlit
- Apresentação final do case

---

## 2. Problema de Negócio

Uma grande empresa de e-commerce possui dados distribuídos em diferentes fontes, como pedidos, clientes, produtos, vendedores, pagamentos, entregas e avaliações de clientes.

Essa fragmentação dificulta:

- A visão consolidada do desempenho comercial
- A análise de atrasos logísticos
- O entendimento da satisfação dos clientes
- A identificação de problemas recorrentes em produtos e entregas
- A criação de modelos analíticos e preditivos
- A geração rápida de insights para tomada de decisão

Além disso, grande parte do valor dos dados está em informações desestruturadas, como comentários de clientes, que normalmente não são bem aproveitados em análises tradicionais.

---

## 3. Solução Proposta

A solução proposta consiste na construção de uma Plataforma de Dados na Dadosfera para centralizar e organizar os dados do e-commerce, aplicando boas práticas de Engenharia de Dados, Qualidade de Dados, Modelagem Analítica e IA Generativa.

A arquitetura proposta utiliza as seguintes camadas:

- Raw Zone: dados brutos carregados a partir dos arquivos originais
- Bronze Zone: dados padronizados e catalogados
- Silver Zone: dados tratados, limpos e integrados
- Gold Zone: modelos analíticos prontos para consumo
- Semantic/Analytics Layer: dashboards e aplicações de dados

Também será criada uma camada de enriquecimento com IA para transformar comentários de clientes em features analíticas, como sentimento, categoria da reclamação, resumo do comentário e risco de insatisfação.

---

## 4. Base de Dados Utilizada

A base escolhida para o projeto é a Olist Brazilian E-Commerce Public Dataset.

Essa base representa um cenário realista de e-commerce brasileiro e contém informações sobre:

- Pedidos
- Clientes
- Produtos
- Vendedores
- Pagamentos
- Entregas
- Avaliações dos clientes
- Categorias de produtos
- Localização geográfica

A base atende ao requisito mínimo do case, pois possui aproximadamente 100 mil pedidos, além de múltiplas tabelas relacionadas ao processo de venda, pagamento, logística e satisfação do cliente.

Link da base:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

## 5. Objetivos Analíticos

Os principais objetivos analíticos deste projeto são:

1. Analisar a evolução de pedidos e faturamento ao longo do tempo
2. Identificar os estados e cidades com maior volume de vendas
3. Avaliar a performance logística por região e vendedor
4. Identificar categorias de produtos com maior atraso de entrega
5. Analisar a satisfação dos clientes por categoria, vendedor e região
6. Usar IA para classificar sentimentos e motivos de reclamação em reviews
7. Disponibilizar dashboards e um Data App para exploração dos dados

---

## 6. Planejamento do Projeto

### 6.1 Etapas

| Etapa | Descrição | Status |
|------|-----------|--------|
| 1 | Definição do problema de negócio | Concluído |
| 2 | Escolha da base de dados | Concluído |
| 3 | Download e exploração inicial dos dados | Em andamento |
| 4 | Carga dos dados na Dadosfera | Pendente |
| 5 | Catalogação dos datasets | Pendente |
| 6 | Criação do dicionário de dados | Pendente |
| 7 | Execução de Data Quality | Pendente |
| 8 | Feature engineering com IA | Pendente |
| 9 | Modelagem dimensional | Pendente |
| 10 | Criação das views finais | Pendente |
| 11 | Construção do dashboard | Pendente |
| 12 | Criação do pipeline | Pendente |
| 13 | Desenvolvimento do Data App | Pendente |
| 14 | Gravação da apresentação | Pendente |

---

### 6.2 Cronograma Simplificado

| Fase | Atividade | Duração Estimada |
|-----|-----------|------------------|
| Planejamento | Definição do escopo, riscos e arquitetura | 1 dia |
| Ingestão | Download, organização e carga dos dados | 1 dia |
| Exploração | Análise inicial e catalogação | 1 dia |
| Qualidade | Validação com Great Expectations | 1 dia |
| Processamento | Tratamento e enriquecimento dos dados | 1 dia |
| IA | Extração de features dos reviews | 1 dia |
| Modelagem | Criação das tabelas dimensionais e fatos | 1 dia |
| Visualização | Criação de dashboard com 5 gráficos | 1 dia |
| Data App | Desenvolvimento em Streamlit | 1 dia |
| Apresentação | Roteiro, gravação e publicação do vídeo | 1 dia |

---

### 6.3 Riscos do Projeto

| Risco | Impacto | Mitigação |
|------|---------|-----------|
| Problemas no upload dos dados | Alto | Validar arquivos localmente antes da carga |
| Inconsistência entre tabelas | Médio | Criar validações de integridade referencial |
| Dados nulos em campos importantes | Médio | Aplicar regras de qualidade e tratamento |
| Limitação no uso de LLM | Médio | Processar amostra representativa dos reviews |
| Falta de tempo para entrega completa | Alto | Priorizar itens obrigatórios e depois bônus |
| Dificuldade com publicação do Data App | Médio | Manter instruções claras para execução local |

---

## 7. Arquitetura da Solução

### 7.1 Arquitetura Conceitual

```text
Fontes de Dados
     |
     v
Arquivos CSV - Olist Dataset
     |
     v
Dadosfera - Coleta / Integração
     |
     v
Raw Zone
     |
     v
Bronze Zone - Dados Padronizados
     |
     v
Silver Zone - Dados Tratados e Integrados
     |
     v
Gold Zone - Modelo Dimensional
     |
     +----------------------+
     |                      |
     v                      v
Dashboard Analítico      Data App Streamlit
     |
     v
Tomada de Decisão
```

---

### 7.2 Camadas de Dados

#### Raw Zone

Armazena os arquivos originais da base Olist sem transformação.

Exemplos:

- `olist_orders_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_customers_dataset.csv`
- `olist_products_dataset.csv`
- `olist_order_reviews_dataset.csv`
- `olist_order_payments_dataset.csv`
- `olist_sellers_dataset.csv`

#### Bronze Zone

Camada com dados carregados, tipados e padronizados.

Exemplos:

- `bronze_orders`
- `bronze_order_items`
- `bronze_customers`
- `bronze_products`
- `bronze_reviews`
- `bronze_payments`
- `bronze_sellers`

#### Silver Zone

Camada com dados tratados, limpos e integrados.

Exemplos:

- `silver_orders_enriched`
- `silver_customer_orders`
- `silver_product_sales`
- `silver_delivery_performance`
- `silver_reviews_enriched`

#### Gold Zone

Camada final para análise e consumo.

Exemplos:

- `dim_cliente`
- `dim_produto`
- `dim_vendedor`
- `dim_tempo`
- `fato_pedidos`
- `fato_pagamentos`
- `fato_reviews`
- `fato_entregas`

---

## 7.3 Dicionário de Dados

O dicionário de dados da base Olist foi criado para documentar tabelas, colunas, chaves, relacionamentos, regras de negócio e uso analítico dos datasets.

Arquivo:

```text
data/dicionario_dados_olist.md
```
---

## 8. Data Quality

A etapa de Data Quality será implementada com Great Expectations.

O objetivo é validar regras como:

- Chaves primárias não nulas
- Datas válidas
- Valores de pagamento maiores ou iguais a zero
- Status de pedidos dentro dos valores esperados
- Integridade entre pedidos e itens
- Integridade entre pedidos e pagamentos
- Integridade entre pedidos e reviews
- Reviews com score entre 1 e 5
- Detecção de dados duplicados
- Detecção de campos críticos nulos

### 8.1 Regras de Qualidade Propostas

| Tabela | Campo | Regra |
|-------|-------|-------|
| orders | order_id | Não pode ser nulo |
| orders | order_status | Deve estar dentro dos status esperados |
| orders | order_purchase_timestamp | Deve ser uma data válida |
| order_items | price | Deve ser maior ou igual a zero |
| order_payments | payment_value | Deve ser maior ou igual a zero |
| order_reviews | review_score | Deve estar entre 1 e 5 |
| customers | customer_state | Não pode ser nulo |
| products | product_category_name | Pode ser nulo, mas deve ser monitorado |

### 8.2 Resultado da Execução

As validações de Data Quality foram executadas com sucesso utilizando Great Expectations.

Resumo da execução:

| Tabela | Sucesso | Expectativas Avaliadas | Expectativas com Sucesso | Expectativas com Falha | % Sucesso |
|---|---|---:|---:|---:|---:|
| orders | True | 7 | 7 | 0 | 100.0% |
| order_items | True | 9 | 9 | 0 | 100.0% |
| customers | True | 6 | 6 | 0 | 100.0% |
| products | True | 6 | 6 | 0 | 100.0% |
| payments | True | 7 | 7 | 0 | 100.0% |
| reviews | True | 5 | 5 | 0 | 100.0% |
| sellers | True | 4 | 4 | 0 | 100.0% |

Relatórios gerados:

```text
data_quality/reports/relatorio_data_quality_olist.md
data_quality/reports/resultado_data_quality_olist.json
```
---

## 9. Uso de GenAI / LLM

A base Olist possui dados desestruturados nos comentários dos clientes, disponíveis na tabela de reviews.

Esses textos serão utilizados para criação de novas features com IA.

### 9.1 Features Geradas

| Feature | Descrição |
|--------|-----------|
| `sentimento` | Classificação do comentário como positivo, neutro ou negativo |
| `categoria_reclamacao` | Tipo principal do problema relatado |
| `resumo_review` | Resumo curto do comentário |
| `risco_churn` | Indicação de risco de perda do cliente |
| `acao_recomendada` | Sugestão de ação para o negócio |
| `palavras_chave` | Principais termos extraídos do comentário |

### 9.2 Exemplo

Entrada:

```text
Produto chegou atrasado e a embalagem veio danificada.
```

Saída esperada:

```json
{
  "sentimento": "negativo",
  "categoria_reclamacao": "entrega",
  "resumo_review": "Cliente relata atraso na entrega e embalagem danificada.",
  "risco_churn": "alto",
  "acao_recomendada": "Acionar logística e oferecer cupom de compensação.",
  "palavras_chave": ["atraso", "entrega", "embalagem danificada"]
}
```

---

## 10. Modelagem de Dados

A modelagem escolhida segue os princípios de Kimball, utilizando tabelas fato e dimensão.

Essa abordagem foi escolhida porque facilita análises descritivas, criação de dashboards e consumo pelos times de negócio.

---

### 10.1 Modelo Dimensional Proposto

```text
                  dim_cliente
                       |
                       |
dim_tempo ---- fato_pedidos ---- dim_produto
                       |
                       |
                  dim_vendedor
                       |
                       |
               fato_pagamentos
                       |
                       |
                fato_reviews
```

---

### 10.2 Dimensões

#### dim_cliente

Campos sugeridos:

- `sk_cliente`
- `customer_id`
- `customer_unique_id`
- `customer_city`
- `customer_state`
- `customer_zip_code_prefix`

#### dim_produto

Campos sugeridos:

- `sk_produto`
- `product_id`
- `product_category_name`
- `product_name_lenght`
- `product_description_lenght`
- `product_photos_qty`
- `product_weight_g`
- `product_length_cm`
- `product_height_cm`
- `product_width_cm`

#### dim_vendedor

Campos sugeridos:

- `sk_vendedor`
- `seller_id`
- `seller_city`
- `seller_state`
- `seller_zip_code_prefix`

#### dim_tempo

Campos sugeridos:

- `sk_tempo`
- `data`
- `ano`
- `mes`
- `dia`
- `trimestre`
- `nome_mes`
- `dia_semana`

---

### 10.3 Fatos

#### fato_pedidos

Métricas sugeridas:

- quantidade de pedidos
- quantidade de itens
- valor total do pedido
- valor de frete
- prazo de entrega
- atraso de entrega
- status do pedido

#### fato_pagamentos

Métricas sugeridas:

- valor pago
- quantidade de parcelas
- tipo de pagamento

#### fato_reviews

Métricas sugeridas:

- review score
- sentimento
- categoria da reclamação
- risco de churn

#### fato_entregas

Métricas sugeridas:

- dias até aprovação
- dias até envio
- dias até entrega
- dias de atraso
- entrega no prazo

---

## 11. Visões Finais

Serão criadas pelo menos duas visões finais para consumo analítico.

### 11.1 Visão Comercial

Nome sugerido:

```text
vw_ecommerce_performance_comercial
```

Objetivo:

Consolidar indicadores de vendas, pedidos, produtos, vendedores e clientes.

Indicadores:

- total de pedidos
- faturamento total
- ticket médio
- quantidade de clientes
- quantidade de vendedores
- categorias mais vendidas
- estados com maior faturamento

---

### 11.2 Visão de Experiência do Cliente

Nome sugerido:

```text
vw_ecommerce_experiencia_cliente
```

Objetivo:

Analisar satisfação, reviews, atrasos e problemas relatados pelos clientes.

Indicadores:

- score médio de avaliação
- percentual de reviews negativos
- principais motivos de reclamação
- atraso médio de entrega
- risco de churn
- sentimento dos comentários

---

## 12. Dashboard Analítico

O dashboard será criado no módulo de visualização da Dadosfera.

Nome sugerido da coleção:

```text
Carlos Santos - 04_2026
```

O planejamento detalhado do dashboard está disponível em:

```text
apresentacao/planejamento_dashboard.md
```

### 12.1 Visualizações Propostas

| Nº | Pergunta de Negócio | Tipo de Visualização |
|---|----------------------|----------------------|
| 1 | Como o faturamento evoluiu ao longo do tempo? | Linha |
| 2 | Quais estados possuem maior volume de pedidos? | Mapa ou barras |
| 3 | Quais categorias possuem maior faturamento? | Barras horizontais |
| 4 | Qual o percentual de pedidos entregues com atraso? | Indicador/KPI |
| 5 | Qual a relação entre atraso e nota do review? | Dispersão |
| 6 | Quais são os principais motivos de reclamação? | Pizza ou barras |
| 7 | Qual o sentimento dos clientes por categoria? | Barras empilhadas |

---

## 13. Pipeline de Dados

O pipeline será responsável por orquestrar o fluxo de processamento dos dados.

### 13.1 Etapas do Pipeline

```text
1. Leitura dos dados brutos
2. Padronização de nomes de colunas
3. Conversão de tipos de dados
4. Validação de qualidade
5. Tratamento de nulos e duplicidades
6. Integração entre tabelas
7. Criação de features com IA
8. Geração das tabelas dimensionais
9. Geração das tabelas fato
10. Catalogação dos ativos finais
```

### 13.2 Pipeline Proposto

Nome sugerido:

```text
pipeline_ecommerce_olist_kimball
```

---

## 14. Data App com Streamlit

Será criado um Data App em Streamlit para exploração interativa dos dados.

O código do Data App está disponível em:

```text
streamlit_app/app.py
```

### 14.1 Funcionalidades

O Data App permitirá:

- Filtrar pedidos por período
- Filtrar por estado
- Filtrar por categoria de produto
- Visualizar KPIs principais
- Analisar faturamento mensal
- Analisar atraso médio de entrega
- Explorar reviews e sentimentos
- Identificar categorias com maior risco de insatisfação

### 14.2 Como Executar Localmente

Acessar a pasta do app:

```bash
cd streamlit_app
```

Instalar dependências:

```bash
pip install -r requirements.txt
```

Executar o app:

```bash
streamlit run app.py
```

---

## 15. Estrutura do Repositório

```text
CARLOS_SANTOS_DDF_TECH_042026/
│
├── README.md
│
├── planejamento/
│   ├── gantt.md
│   ├── riscos_custos_recursos.md
│   └── kanban.md
│
├── data/
│   ├── instrucoes_download_olist.md
│   └── sample/
│
├── notebooks/
│   ├── 01_exploracao_olist.ipynb
│   ├── 02_data_quality_great_expectations.ipynb
│   ├── 03_feature_engineering_llm.ipynb
│   └── 04_modelagem_kimball.ipynb
│
├── sql/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│       ├── dim_cliente.sql
│       ├── dim_produto.sql
│       ├── dim_vendedor.sql
│       ├── dim_tempo.sql
│       ├── fato_pedidos.sql
│       ├── fato_pagamentos.sql
│       ├── fato_reviews.sql
│       └── vw_ecommerce_experiencia_cliente.sql
│
├── data_quality/
│   ├── expectations/
│   └── reports/
│
├── streamlit_app/
│   ├── app.py
│   ├── requirements.txt
│   └── README.md
│
├── evidencias/
│   ├── dadosfera/
│   ├── dashboard/
│   ├── data_quality/
│   ├── pipeline/
│   └── data_app/
│
└── apresentacao/
    ├── roteiro_video.md
    ├── arquitetura_solucao.md
    └── link_video.md
```

---

## 16. Evidências dos Ativos na Dadosfera

Esta seção será preenchida após a criação dos ativos na Dadosfera.

### 16.1 Datasets

Os arquivos da base Olist foram carregados na Dadosfera na camada Raw, utilizando o schema `PUBLIC` e o prefixo `RAW_` para representar a zona de dados brutos.

| Ativo | Tabela na Dadosfera | Status | Evidência |
|------|----------------------|--------|-----------|
| Orders | `PUBLIC.RAW_ORDERS` | Concluído | `evidencias/dadosfera/catalogo/catalogo_raw_orders.png` |
| Order Items | `PUBLIC.RAW_ORDER_ITEMS` | Concluído | `evidencias/dadosfera/catalogo/catalogo_raw_order_items.png` |
| Customers | `PUBLIC.RAW_CUSTOMERS` | Concluído | `evidencias/dadosfera/catalogo/catalogo_raw_customers.png` |
| Products | `PUBLIC.RAW_PRODUCTS` | Concluído | `evidencias/dadosfera/catalogo/catalogo_raw_products.png` |
| Payments | `PUBLIC.RAW_PAYMENTS` | Concluído | `evidencias/dadosfera/catalogo/catalogo_raw_payments.png` |
| Reviews | `PUBLIC.RAW_REVIEWS` | Concluído | `evidencias/dadosfera/catalogo/catalogo_raw_reviews.png` |
| Sellers | `PUBLIC.RAW_SELLERS` | Concluído | `evidencias/dadosfera/catalogo/catalogo_raw_sellers.png` |

---

### 16.2 Dashboard

| Ativo | Link | Print |
|------|------|-------|
| Dashboard E-commerce Analytics | Pendente | Pendente |

---

### 16.3 Pipeline

| Ativo | Link | Print |
|------|------|-------|
| pipeline_ecommerce_olist_kimball | Pendente | Pendente |

---

### 16.4 Data App

| Ativo | Link | Print |
|------|------|-------|
| Streamlit App | Pendente | Pendente |

---

## 17. Apresentação do Case

O vídeo final será publicado como não listado no YouTube.

Link do vídeo:

```text
Pendente
```

A apresentação irá abordar:

1. Apresentação pessoal
2. Contexto do problema
3. Base de dados escolhida
4. Arquitetura proposta com Dadosfera
5. Processo de carga e catalogação
6. Data Quality
7. Uso de IA nos reviews
8. Modelagem dimensional
9. Dashboard criado
10. Pipeline criado
11. Data App em Streamlit
12. Ganhos técnicos e de negócio com a Dadosfera

---

## 18. Benefícios da Solução com Dadosfera

A adoção da Dadosfera permite reduzir o tempo entre dados e valor por meio de:

- Centralização dos dados em uma única plataforma
- Redução da complexidade operacional
- Organização dos dados em camadas
- Catalogação e governança dos ativos
- Facilidade de criação de pipelines
- Integração com visualização de dados
- Possibilidade de uso de IA e LLMs
- Maior velocidade na entrega de análises para o negócio

---

## 19. Ganhos Esperados

Com a solução proposta, a empresa poderá:

- Monitorar vendas e pedidos com mais agilidade
- Identificar problemas logísticos rapidamente
- Melhorar a experiência dos clientes
- Priorizar categorias e vendedores com maior impacto
- Usar comentários de clientes como fonte estratégica de informação
- Reduzir esforço manual de análise
- Criar uma base sólida para modelos preditivos e prescritivos

---

## 20. Tecnologias Utilizadas

- Dadosfera
- Python
- SQL
- Pandas
- Great Expectations
- OpenAI / LLM
- Streamlit
- Metabase / Módulo de Visualização
- GitHub
- Google Colab

---

## 21. Conclusão

Este case demonstra como uma Plataforma de Dados moderna pode transformar dados transacionais e desestruturados de e-commerce em ativos analíticos de alto valor.

A proposta combina Engenharia de Dados, Qualidade, Modelagem Dimensional, IA Generativa, Visualização e Data Apps para entregar uma solução completa, escalável e orientada à tomada de decisão.

A Dadosfera atua como elemento central da arquitetura, acelerando o ciclo de vida dos dados desde a integração até a geração de valor para o negócio.
