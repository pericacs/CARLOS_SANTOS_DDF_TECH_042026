-- ============================================================
-- View: PUBLIC.GOLD_VW_ECOMMERCE_EXPERIENCIA_CLIENTE
-- Camada: Gold
-- Objetivo: Visão consolidada para análise de experiência do cliente
-- Origem: PUBLIC.GOLD_FATO_REVIEWS + PUBLIC.GOLD_FATO_PEDIDOS + dimensões
-- ============================================================

CREATE OR REPLACE VIEW PUBLIC.GOLD_VW_ECOMMERCE_EXPERIENCIA_CLIENTE AS
SELECT
    fr.REVIEW_ID,
    fr.ORDER_ID,

    dt.DATA AS DATA_REVIEW,
    dt.ANO,
    dt.MES,
    dt.TRIMESTRE,

    dc.CUSTOMER_STATE AS ESTADO_CLIENTE,
    dc.CUSTOMER_CITY AS CIDADE_CLIENTE,

    dp.PRODUCT_CATEGORY_NAME,

    dv.SELLER_STATE AS ESTADO_VENDEDOR,
    dv.SELLER_CITY AS CIDADE_VENDEDOR,

    fp.ORDER_STATUS,
    fp.DELIVERY_STATUS,
    fp.DATA_COMPRA,
    fp.DATA_ENTREGA_CLIENTE,
    fp.DATA_ESTIMADA_ENTREGA,
    fp.FLAG_ENTREGA_ATRASADA,
    fp.DIAS_ATE_ENTREGA,
    fp.DIAS_ATRASO,

    fr.REVIEW_SCORE,
    fr.REVIEW_CLASSIFICATION,
    fr.IS_NEGATIVE_REVIEW,
    fr.IS_POSITIVE_REVIEW,
    fr.HAS_REVIEW_COMMENT,
    fr.DISSATISFACTION_RISK,
    fr.REVIEW_TOPIC,
    fr.REVIEW_COMMENT_TITLE,
    fr.REVIEW_COMMENT_MESSAGE,

    CASE
        WHEN fp.FLAG_ENTREGA_ATRASADA = 1 AND fr.REVIEW_SCORE <= 2
            THEN 'Atraso com review negativo'

        WHEN fp.FLAG_ENTREGA_ATRASADA = 1 AND fr.REVIEW_SCORE >= 4
            THEN 'Atraso com review positivo'

        WHEN fp.FLAG_ENTREGA_ATRASADA = 0 AND fr.REVIEW_SCORE <= 2
            THEN 'No prazo com review negativo'

        WHEN fp.FLAG_ENTREGA_ATRASADA = 0 AND fr.REVIEW_SCORE >= 4
            THEN 'No prazo com review positivo'

        ELSE 'Cenário neutro ou não classificado'
    END AS CATEGORIA_EXPERIENCIA

FROM PUBLIC.GOLD_FATO_REVIEWS fr

LEFT JOIN PUBLIC.GOLD_FATO_PEDIDOS fp
    ON fr.ORDER_ID = fp.ORDER_ID

LEFT JOIN PUBLIC.GOLD_DIM_TEMPO dt
    ON fr.SK_TEMPO_REVIEW = dt.SK_TEMPO

LEFT JOIN PUBLIC.GOLD_DIM_CLIENTE dc
    ON fr.SK_CLIENTE = dc.SK_CLIENTE

LEFT JOIN PUBLIC.GOLD_DIM_PRODUTO dp
    ON fp.SK_PRODUTO = dp.SK_PRODUTO

LEFT JOIN PUBLIC.GOLD_DIM_VENDEDOR dv
    ON fp.SK_VENDEDOR = dv.SK_VENDEDOR;