# Soy Turbo — Modelagem de Banco de Dados de uma Concessionária

Projeto de modelagem e implementação de um banco de dados relacional para uma
concessionária de veículos fictícia, contemplando cadastro de veículos, clientes,
vendas e [ajuste conforme o escopo real].

Desenvolvido em equipe como trabalho final da disciplina de Banco de
Dados (PUC-PR, 2025/2).

## Diagrama Entidade-Relacionamento

<img width="1550" height="749" alt="Captura de tela 2025-11-18 142639" src="https://github.com/user-attachments/assets/a3daf643-ecfa-4e0d-9ba5-3a5a19aaf896" />

## Tecnologias

- MySQL 8
- MySQL Workbench (modelagem e engenharia reversa)

## Estrutura do banco

O schema `soy_turbo` é composto por 9 tabelas, organizadas em três blocos:
**funcionários** (gerentes, vendedores, fretadores), **catálogo de veículos**
(fornecedores, modelos, automóveis vendidos) e **operação comercial**
(compradores, contratos, entrega).

### Tabelas

| Tabela | Descrição | PK | FKs |
|---|---|---|---|
| `gerentes` | Topo da hierarquia. Contrata vendedores e fretadores e fecha acordos com fornecedores. | `id_gerente` | — |
| `vendedores` | Registram compradores, automóveis e contratos. | `id_vendedor` | `id_gerente` |
| `fretadores` | Responsáveis pelas entregas domiciliares. | `id_fretador` | `id_gerente` |
| `fornecedores` | Empresas que fornecem os modelos à concessionária. | `id_fornecedor` | `id_gerente` |
| `modelos` | Catálogo de modelos (ex.: Fiat Argo, Honda Civic). | `codigo_modelo` | `id_fornecedor` |
| `automoveis_vendidos` | Unidade física do veículo: cor, ano, km e preço. | `codigo_auto` | `codigo_modelo` |
| `compradores` | Clientes cadastrados. Fora da hierarquia interna. | `id_comprador` | — |
| `contratos` | Núcleo do sistema. Liga vendedor, comprador e veículo, e define pagamento, entrega, seguro e garantia. | `codigo_contrato` | `id_vendedor`, `codigo_auto`, `id_comprador` |
| `entrega` | Data, horário e fretador designado, quando a opção é `ENTREGA`. | `codigo_entrega` | `id_fretador`, `codigo_contrato` |

### Volume de dados de exemplo

| Tabela | Registros |
|---|---:|
| `gerentes` | 10 |
| `fornecedores` | 15 |
| `fretadores` | 20 |
| `vendedores` | 20 |
| `compradores` | 40 |
| `modelos` | 25 |
| `automoveis_vendidos` | 50 |
| `contratos` | 50 |
| `entrega` | 25 |

Apenas 25 das 50 vendas geram entrega — os demais contratos usam a opção
`RETIRADA`. Isso permite exercitar `LEFT JOIN` e `NOT IN` em consultas que
buscam contratos sem entrega associada.

### Escolhas de tipos

- **`ENUM`** em `forma_pagamento` (`À VISTA` / `PARCELADO`), `opcao_entrega`
  (`RETIRADA` / `ENTREGA`), `status_garantia` e `status_seguro` — garante
  integridade em domínios fechados. Substituiu um `BOOLEAN` usado na primeira
  versão do modelo.
- **`CHAR(11)` para CPF** e **`CHAR(14)` para CNPJ**, já que têm comprimento fixo.
- **`DECIMAL(10,2)`** em salários e `preco_venda`, evitando os erros de
  arredondamento de ponto flutuante.
- **`YEAR`** em `ano`, **`DATE`** em `data_entrega` e **`TIME`** em `horario`.
- **`TIMESTAMP DEFAULT CURRENT_TIMESTAMP`** em `contratos.criado_em`.
- **`UNIQUE`** em CPF, CNPJ, e-mail e telefone; **`NOT NULL`** em todos os
  atributos.
## Como executar

**Pré-requisito:** MySQL 8 instalado.

```bash
# Clone o repositório
git clone https://github.com/RafaeldeFreitasBrandao/soy-turbo-banco-dados.git
cd soy-turbo-banco-dados

# Execute o script (cria o schema, as tabelas e insere os dados de exemplo)
mysql -u root -p < soy_turbo.sql
```

Para conferir:

```sql
USE soy_turbo;
SHOW TABLES;
```


## Decisões de modelagem

- **Normalização até a 3FN**, evitando redundância entre [tabela] e [tabela].
- **Tabela associativa `[nome]`** para resolver o relacionamento N:N entre [X] e [Y].
- **Chave estrangeira com `ON DELETE RESTRICT`** em [tabela], para impedir a exclusão de um cliente com vendas registradas.

## Documentação

O relatório completo do trabalho está em [annotated-Entrega_PJBL3_SOY_TURBO_BD.pdf](https://github.com/user-attachments/files/29858907/annotated-Entrega_PJBL3_SOY_TURBO_BD.pdf)

