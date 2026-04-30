-- ============================================================
-- Tabela: dim_produto
-- Camada: Gold
-- Objetivo: Dimensão de produtos enriquecida com categoria traduzida
-- Origem: products + category_translation
-- ============================================================

CREATE OR REPLACE TABLE gold.dim_produto AS
SELECT
    ROW_NUMBER() OVER (ORDER BY p.product_id) AS sk_produto,
    p.product_id,
    p.product_category_name,
    COALESCE(t.product_category_name_english, p.product_category_name) AS product_category_name_english,
    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM silver.products p
LEFT JOIN silver.category_translation t
    ON p.product_category_name = t.product_category_name
WHERE p.product_id IS NOT NULL;