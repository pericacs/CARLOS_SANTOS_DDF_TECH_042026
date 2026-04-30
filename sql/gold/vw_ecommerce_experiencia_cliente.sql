-- ============================================================
-- View: vw_ecommerce_experiencia_cliente
-- Camada: Gold
-- Objetivo: Visão consolidada para análise de experiência do cliente
-- Origem: fato_reviews + fato_pedidos + dimensões
-- ============================================================

CREATE OR REPLACE VIEW gold.vw_ecommerce_experiencia_cliente AS
SELECT
    fr.review_id,
    fr.order_id,

    dt.data AS data_review,
    dt.ano,
    dt.mes,
    dt.trimestre,

    dc.customer_state AS estado_cliente,
    dc.customer_city AS cidade_cliente,

    dp.product_category_name,
    dp.product_category_name_english,

    dv.seller_state AS estado_vendedor,
    dv.seller_city AS cidade_vendedor,

    fp.order_status,
    fp.data_compra,
    fp.data_entrega_cliente,
    fp.data_estimada_entrega,
    fp.flag_entrega_atrasada,
    fp.dias_ate_entrega,
    fp.dias_atraso,

    fr.review_score,
    fr.classificacao_review,
    fr.flag_review_negativo,
    fr.flag_review_positivo,
    fr.flag_possui_comentario,
    fr.risco_insatisfacao,
    fr.review_comment_title,
    fr.review_comment_message,

    CASE
        WHEN fp.flag_entrega_atrasada = 1 AND fr.review_score <= 2
        THEN 'Atraso com review negativo'

        WHEN fp.flag_entrega_atrasada = 1 AND fr.review_score >= 4
        THEN 'Atraso com review positivo'

        WHEN fp.flag_entrega_atrasada = 0 AND fr.review_score <= 2
        THEN 'No prazo com review negativo'

        WHEN fp.flag_entrega_atrasada = 0 AND fr.review_score >= 4
        THEN 'No prazo com review positivo'

        ELSE 'Cenário neutro ou não classificado'
    END AS categoria_experiencia

FROM gold.fato_reviews fr

LEFT JOIN gold.fato_pedidos fp
    ON fr.order_id = fp.order_id

LEFT JOIN gold.dim_tempo dt
    ON fr.sk_tempo_review = dt.sk_tempo

LEFT JOIN gold.dim_cliente dc
    ON fr.sk_cliente = dc.sk_cliente

LEFT JOIN gold.dim_produto dp
    ON fp.sk_produto = dp.sk_produto

LEFT JOIN gold.dim_vendedor dv
    ON fp.sk_vendedor = dv.sk_vendedor;