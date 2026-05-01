# Camada Gold - Modelagem Dimensional

## Objetivo

Esta pasta contém os scripts SQL responsáveis pela criação da camada Gold do projeto.

A camada Gold representa os dados organizados em modelo dimensional, seguindo os princípios de Kimball, com tabelas dimensão, tabelas fato e views analíticas preparadas para consumo em dashboard e Data App.

---

## Fluxo de Camadas

```text
PUBLIC.RAW_*
    ↓
PUBLIC.BRONZE_*
    ↓
PUBLIC.SILVER_*_ENRICHED
    ↓
PUBLIC.GOLD_*