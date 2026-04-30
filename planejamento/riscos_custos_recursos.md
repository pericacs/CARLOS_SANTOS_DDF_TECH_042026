# Riscos, Custos, Recursos e Dependências

## 1. Objetivo

Este documento apresenta uma análise complementar de planejamento do case técnico da Dadosfera, considerando riscos, custos, recursos necessários e principais dependências do projeto.

O objetivo é demonstrar uma visão de gestão do projeto, além da execução técnica.

---

## 2. Recursos Necessários

### 2.1 Recursos Técnicos

| Recurso | Finalidade |
|---|---|
| GitHub | Versionamento e entrega do projeto |
| Dadosfera | Carga, catalogação, pipeline e visualização dos dados |
| Python | Exploração, qualidade e processamento local |
| Pandas | Leitura e análise dos arquivos CSV |
| Great Expectations | Validação de qualidade dos dados |
| Streamlit | Criação do Data App |
| SQL | Modelagem dimensional e views analíticas |
| Kaggle | Download da base Olist |
| YouTube | Publicação do vídeo não listado |
| VS Code | Desenvolvimento do projeto |

---

### 2.2 Recursos de Dados

| Recurso | Descrição |
|---|---|
| Base Olist | Dataset público de e-commerce brasileiro |
| Arquivos CSV | Fonte principal do projeto |
| Reviews dos clientes | Fonte para análise de satisfação e possível uso com IA |
| Dados de pedidos | Fonte para análise comercial e logística |
| Dados de pagamentos | Fonte para análise financeira |
| Dados de produtos | Fonte para análise por categoria |

---

### 2.3 Recursos Humanos

| Papel | Responsabilidade |
|---|---|
| Engenheiro de Dados | Estruturar ingestão, qualidade, modelagem e pipeline |
| Analista de Dados/BI | Construir dashboard e indicadores |
| Usuário de Negócio | Validar perguntas de negócio e indicadores |
| Gestor do Projeto | Acompanhar escopo, riscos e entregáveis |

Neste case, os papéis foram simulados e executados pelo autor do projeto.

---

## 3. Custos Estimados

Como o projeto utiliza base pública e ferramentas com opção gratuita/local, os custos diretos são baixos.

| Item | Custo Estimado | Observação |
|---|---:|---|
| Base Olist | R$ 0,00 | Dataset público no Kaggle |
| GitHub | R$ 0,00 | Repositório público |
| Python | R$ 0,00 | Open source |
| Pandas | R$ 0,00 | Open source |
| Great Expectations | R$ 0,00 | Open source |
| Streamlit local | R$ 0,00 | Execução local |
| YouTube | R$ 0,00 | Publicação não listada |
| Dadosfera | Conforme ambiente disponível | Utilizado ambiente fornecido/avaliado |

---

## 4. Riscos do Projeto

| Risco | Probabilidade | Impacto | Mitigação |
|---|---|---|---|
| Dificuldade no download da base | Média | Médio | Documentar download via navegador e Kaggle API |
| Arquivos CSV não encontrados localmente | Alta | Médio | Criar validação automática nos scripts |
| Dados nulos em campos importantes | Alta | Médio | Mapear nulos no relatório de exploração e Data Quality |
| Erros na instalação do Great Expectations | Média | Médio | Fixar versão estável no comando de instalação |
| Incompatibilidade de SQL entre engines | Média | Alto | Manter SQL documentado e adaptar sintaxe conforme ambiente da Dadosfera |
| Falta de acesso à Dadosfera | Baixa/Média | Alto | Manter scripts e evidências locais versionadas no GitHub |
| Dashboard incompleto | Média | Alto | Planejar mais de 5 visualizações para garantir o mínimo exigido |
| Data App não executar por falta dos CSVs | Média | Médio | Documentar estrutura esperada em `data/raw/` |
| Envio acidental de dados grandes ao GitHub | Média | Médio | Usar `.gitignore` bloqueando CSV, ZIP e Parquet |
| Falta de evidências visuais | Média | Alto | Criar checklist de prints e links |
| Vídeo sem mostrar ativos principais | Média | Alto | Usar roteiro de gravação com ordem sugerida |

---

## 5. Dependências

### 5.1 Dependências Técnicas

| Dependência | Necessária para |
|---|---|
| Download da base Olist | Exploração, Data Quality, Data App e carga |
| Instalação das bibliotecas Python | Execução dos scripts |
| Acesso à Dadosfera | Carga, catálogo, pipeline e dashboard |
| Git configurado | Versionamento e envio ao GitHub |
| Navegador web | Dadosfera, Kaggle, GitHub e YouTube |
| VS Code | Edição dos arquivos do projeto |

---

### 5.2 Dependências entre Atividades

| Atividade | Depende de |
|---|---|
| Exploração inicial | Download dos CSVs |
| Data Quality | Download dos CSVs |
| Dicionário de dados | Entendimento das tabelas |
| Modelagem Gold | Conhecimento das chaves e relacionamentos |
| Dashboard | Criação das views/tabelas analíticas |
| Data App | Disponibilidade dos CSVs locais |
| Evidências | Execução das etapas práticas |
| Vídeo | Projeto e evidências finalizadas |

---

## 6. Premissas

As principais premissas do projeto são:

- a base Olist representa um cenário realista de e-commerce;
- os arquivos CSV estão disponíveis localmente em `data/raw/`;
- os dados podem ser carregados na Dadosfera;
- a Dadosfera será usada para catalogação, pipeline e dashboard;
- os scripts locais servem como apoio e rastreabilidade técnica;
- o GitHub será usado como repositório central da entrega;
- o vídeo final será publicado como não listado no YouTube.

---

## 7. Restrições

| Restrição | Impacto |
|---|---|
| Dados CSV não versionados no GitHub | Necessário documentar download |
| Tempo limitado de entrega | Priorizar itens obrigatórios |
| Dataset público e histórico | Não representa dados em tempo real |
| Possível limitação de acesso à Dadosfera | Necessário manter documentação e prints |
| Dependência de execução local do Streamlit | App precisa dos CSVs em `data/raw/` |

---

## 8. Estratégia de Mitigação

Para reduzir os riscos do projeto, foram adotadas as seguintes estratégias:

1. Criar documentação detalhada no GitHub.
2. Manter `.gitignore` para evitar envio de arquivos grandes.
3. Criar scripts reproduzíveis para exploração e Data Quality.
4. Criar dicionário de dados e planejamento do dashboard.
5. Criar checklist de evidências.
6. Criar roteiro de vídeo para evitar esquecer etapas importantes.
7. Planejar mais visualizações do que o mínimo solicitado.
8. Separar claramente documentação, código, SQL, evidências e apresentação.

---

## 9. Priorização

### 9.1 Itens Obrigatórios

| Item | Prioridade |
|---|---|
| Carga de dados com mais de 100 mil registros | Alta |
| Catalogação na Dadosfera | Alta |
| Data Quality | Alta |
| Dashboard com 5 visualizações | Alta |
| GitHub com documentação | Alta |

---

### 9.2 Itens Diferenciais

| Item | Prioridade |
|---|---|
| Modelagem Kimball | Média/Alta |
| Data App Streamlit | Média/Alta |
| Uso de reviews para IA/LLM | Média |
| Roteiro de vídeo estruturado | Média |
| Checklist de evidências | Média |

---

## 10. Conclusão

A análise de riscos, custos, recursos e dependências demonstra que o projeto é viável tecnicamente, possui baixo custo direto e pode ser executado com ferramentas acessíveis.

Os principais pontos de atenção estão relacionados à execução prática na Dadosfera, geração das evidências e garantia de que todos os links e prints estejam disponíveis na entrega final.

Com o planejamento proposto, o projeto fica mais organizado, rastreável e aderente aos critérios do case técnico.