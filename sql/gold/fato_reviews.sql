-- ============================================================
-- Tabela: fato_reviews
-- Camada: Gold
-- Objetivo: Fato de avaliações dos clientes
-- Origem: reviews + orders + dim_cliente + dim_tempo
-- ============================================================

CREATE OR REPLACE TABLE gold.fato_reviews AS
SELECT
    r.review_id,
    r.order_id,
    dc.sk_cliente,
    dt.sk_tempo AS sk_tempo_review,

    r.review_score,
    r.review_comment_title,
    r.review_comment_message,
    CAST(r.review_creation_date AS DATE) AS data_criacao_review,
    CAST(r.review_answer_timestamp AS DATE) AS data_resposta_review,

    CASE
        WHEN r.review_score <= 2 THEN 'Negativo'
        WHEN r.review_score = 3 THEN 'Neutro'
        WHEN r.review_score >= 4 THEN 'Positivo'
        ELSE 'Não Classificado'
    END AS classificacao_review,

    CASE
        WHEN r.review_score <= 2 THEN 1
        ELSE 0
    END AS flag_review_negativo,

    CASE
        WHEN r.review_score >= 4 THEN 1
        ELSE 0
    END AS flag_review_positivo,

    CASE
        WHEN r.review_comment_message IS NOT NULL
             AND LENGTH(TRIM(r.review_comment_message)) > 0
        THEN 1
        ELSE 0
    END AS flag_possui_comentario,

    CASE
        WHEN r.review_score <= 2
             AND r.review_comment_message IS NOT NULL
        THEN 'Alto'
        WHEN r.review_score = 3
             AND r.review_comment_message IS NOT NULL
        THEN 'Médio'
        WHEN r.review_score >= 4
        THEN 'Baixo'
        ELSE 'Não Avaliado'
    END AS risco_insatisfacao

FROM silver.reviews r

LEFT JOIN silver.orders o
    ON r.order_id = o.order_id

LEFT JOIN gold.dim_cliente dc
    ON o.customer_id = dc.customer_id

LEFT JOIN gold.dim_tempo dt
    ON CAST(r.review_creation_date AS DATE) = dt.data

WHERE r.review_id IS NOT NULL;