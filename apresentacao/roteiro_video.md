# Roteiro do Vídeo de Apresentação - Case Técnico Dadosfera

## 1. Objetivo do Vídeo

Este roteiro tem como objetivo orientar a gravação da apresentação final do case técnico da Dadosfera.

O vídeo deve demonstrar a solução construída, explicar as decisões técnicas e evidenciar como a Dadosfera reduz o tempo entre dados e valor para o negócio.

---

## 2. Estrutura Recomendada

Tempo sugerido: entre 8 e 12 minutos.

| Bloco | Tema | Tempo estimado |
|---|---|---:|
| 1 | Apresentação pessoal | 1 min |
| 2 | Contexto do problema | 1 min |
| 3 | Base de dados escolhida | 1 min |
| 4 | Arquitetura da solução | 1 min |
| 5 | Carga e catalogação na Dadosfera | 1 a 2 min |
| 6 | Data Quality | 1 min |
| 7 | Modelagem dimensional | 1 min |
| 8 | Dashboard e análises | 2 min |
| 9 | Data App | 1 min |
| 10 | Conclusão | 1 min |

---

## 3. Roteiro Falado

### 3.1 Abertura

Olá, meu nome é Carlos André Cardoso dos Santos.

Neste vídeo, vou apresentar a solução desenvolvida para o case técnico da Dadosfera.

O objetivo do projeto foi construir uma plataforma de dados para análise de e-commerce, utilizando dados públicos da Olist, com foco em vendas, logística, satisfação do cliente, qualidade de dados, modelagem analítica e geração de valor para o negócio.

---

### 3.2 Contexto do Problema

O problema proposto considera uma empresa de e-commerce que possui dados distribuídos em diferentes fontes, como pedidos, clientes, produtos, vendedores, pagamentos, entregas e avaliações dos clientes.

Essa fragmentação dificulta a criação de uma visão consolidada do negócio, prejudica a análise de performance comercial, dificulta a identificação de problemas logísticos e reduz a capacidade de entender a experiência real dos clientes.

Além disso, parte importante da informação está em dados desestruturados, como comentários dos clientes em reviews, que normalmente não são bem aproveitados em análises tradicionais.

---

### 3.3 Base de Dados Escolhida

Para este case, escolhi a base Brazilian E-Commerce Public Dataset by Olist, disponível no Kaggle.

Essa base possui aproximadamente 100 mil pedidos e várias tabelas relacionadas, incluindo pedidos, itens, clientes, produtos, pagamentos, vendedores, geolocalização e avaliações.

Ela foi escolhida porque representa um cenário realista de e-commerce brasileiro e permite trabalhar com várias etapas importantes de uma plataforma de dados, como integração, qualidade, modelagem dimensional, análise comercial, análise logística e análise de satisfação dos clientes.

---

### 3.4 Arquitetura da Solução

A arquitetura proposta foi organizada em camadas.

Na camada Raw, os arquivos CSV originais são mantidos sem transformação.

Na camada Bronze, os dados são carregados e padronizados.

Na camada Silver, os dados são tratados, limpos e integrados.

Na camada Gold, são criadas as tabelas dimensionais e fatos, seguindo uma modelagem Kimball.

Por fim, os dados são disponibilizados para consumo por meio de dashboard analítico e Data App em Streamlit.

A Dadosfera entra como plataforma central para integração, organização, catalogação, processamento e disponibilização dos ativos de dados.

---

### 3.5 Carga e Catalogação na Dadosfera

Na Dadosfera, os datasets da base Olist foram carregados e organizados em zonas de dados.

Foram considerados os principais arquivos da base, como orders, order_items, customers, products, payments, reviews, sellers, geolocation e category_translation.

Também foi criado um dicionário de dados documentando as principais tabelas, colunas, chaves, relacionamentos, regras de qualidade e finalidade analítica de cada dataset.

Essa documentação apoia a governança dos dados e facilita o entendimento dos ativos por usuários técnicos e de negócio.

---

### 3.6 Data Quality

Para a etapa de Data Quality, foram implementadas validações com Great Expectations.

As principais regras aplicadas foram:

- validação de chaves obrigatórias;
- verificação de valores nulos;
- verificação de unicidade em identificadores principais;
- validação de valores monetários maiores ou iguais a zero;
- validação de review score entre 1 e 5;
- validação de status de pedidos dentro dos valores esperados;
- validação de tipos de pagamento dentro dos valores esperados.

O objetivo dessa etapa é garantir que os dados estejam confiáveis antes de serem utilizados em dashboards, modelagem e análises de negócio.

---

### 3.7 Modelagem Dimensional

A camada Gold foi modelada seguindo os princípios de Kimball, com tabelas dimensão e fato.

Foram propostas as seguintes dimensões:

- dim_cliente;
- dim_produto;
- dim_vendedor;
- dim_tempo.

E as seguintes tabelas fato:

- fato_pedidos;
- fato_pagamentos;
- fato_reviews.

Também foram criadas views analíticas para facilitar o consumo dos dados:

- vw_ecommerce_performance_comercial;
- vw_ecommerce_experiencia_cliente.

Essa modelagem permite responder perguntas sobre faturamento, pedidos, ticket médio, atraso de entrega, categorias de produtos, vendedores, formas de pagamento e satisfação dos clientes.

---

### 3.8 Dashboard Analítico

O dashboard foi planejado para responder perguntas comerciais, logísticas e de experiência do cliente.

As principais visualizações propostas são:

- evolução do faturamento mensal;
- pedidos por estado do cliente;
- faturamento por categoria de produto;
- percentual de entregas atrasadas;
- ticket médio mensal;
- nota média por categoria;
- relação entre atraso e review negativo;
- risco de insatisfação por estado.

Com essas visualizações, a área de negócio consegue identificar oportunidades de melhoria, categorias mais relevantes, regiões com maior volume de vendas e pontos críticos na experiência do cliente.

---

### 3.9 Data App

Além do dashboard, foi criado um Data App em Streamlit.

O app permite explorar os dados de forma interativa, com filtros por estado, categoria e status do pedido.

Ele apresenta KPIs como total de pedidos, faturamento, ticket médio, percentual de entregas atrasadas e nota média dos reviews.

Também apresenta gráficos de faturamento mensal, pedidos por estado, faturamento por categoria, categorias com pior nota média e relação entre atraso de entrega e classificação do review.

Esse Data App demonstra como os dados tratados podem ser disponibilizados rapidamente em uma interface simples para usuários de negócio.

---

### 3.10 Ganhos com a Dadosfera

A Dadosfera ajuda a reduzir o tempo entre dados e valor porque centraliza em uma única plataforma várias etapas do ciclo de vida dos dados.

Com ela, é possível acelerar a coleta, organização, catalogação, processamento, qualidade, visualização e disponibilização dos dados.

Isso reduz dependências manuais, melhora a governança, aumenta a rastreabilidade e permite que as áreas de negócio consumam informações com mais rapidez e confiança.

---

### 3.11 Encerramento

Como resultado, este case demonstrou uma solução completa de dados para e-commerce, cobrindo desde a ingestão dos dados brutos até a geração de insights por dashboard e Data App.

A solução proposta combina Engenharia de Dados, Qualidade de Dados, Modelagem Dimensional, Análise de Negócio e uso de dados desestruturados para apoiar decisões comerciais, logísticas e de experiência do cliente.

Obrigado pela oportunidade de apresentar este projeto.

---

## 4. Ordem Sugerida para Gravação da Tela

Durante a gravação, seguir esta ordem:

1. Mostrar o repositório GitHub.
2. Mostrar o README principal.
3. Mostrar a estrutura de pastas.
4. Mostrar o dicionário de dados.
5. Mostrar os scripts de Data Quality.
6. Mostrar o relatório gerado.
7. Mostrar os SQLs da camada Gold.
8. Mostrar o planejamento do dashboard.
9. Mostrar a Dadosfera com os datasets carregados.
10. Mostrar a catalogação dos ativos.
11. Mostrar o dashboard.
12. Mostrar o Data App em execução.
13. Mostrar a conclusão no README.

---

## 5. Checklist Antes de Gravar

Antes de gravar o vídeo, validar:

- [X] Repositório GitHub atualizado
- [X] README completo
- [X] Dicionário de dados criado
- [X] Script de exploração criado
- [X] Relatório de exploração gerado
- [X] Script de Data Quality criado
- [X] Relatório de Data Quality gerado
- [X] SQLs da camada Gold criados
- [X] Planejamento do dashboard criado
- [X] Data App funcionando localmente
- [X] Prints salvos em `evidencias/`
- [X] Datasets carregados na Dadosfera
- [X] Links dos ativos adicionados ao README
- [X] Dashboard criado na Dadosfera
- [X] Link do vídeo adicionado ao README

---

## 6. Link do Vídeo

Após publicar o vídeo no YouTube como não listado, adicionar o link abaixo:

https://youtu.be/m6fCxcJlSaw

```text
concluido
```