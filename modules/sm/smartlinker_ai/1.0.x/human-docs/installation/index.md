# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **AI CKEditor** (`ai_ckeditor`) and **AI Search** (`ai_search`) — both hard
  dependencies, part of the AI module ecosystem.
- Supporting pieces the maintainers document for a working setup:
  - **AI Core** and an **AI provider** (for example the OpenAI provider, using a
    model such as GPT-4o).
  - A **vector database** behind AI Search — the documented path is the **Milvus**
    provider backed by **Zilliz Cloud** (Zilliz's free tier gives one cluster with
    5 GB storage).

There are no third-party PHP library requirements for SmartLinker AI itself, but the
AI provider and vector database do require accounts, API keys, and configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/smartlinker_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI CKEditor and
AI Search modules and any other shared dependencies as needed. You will also need
the AI provider and Milvus/vector-database modules for AI Search — install those per
their own documentation.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smartlinker_ai -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smartlinker_ai -y
```

## Store credentials securely

The AI provider and the vector database (Zilliz/Milvus) each need an API key or
token. Keep these out of plain configuration — store them via Drupal's Key module or
the AI module's credential handling, backed by environment variables, rather than
committing them anywhere.

## Next step

Installing the code is only the start — SmartLinker AI needs a working AI Search
index and the CKEditor feature switched on before it can generate links. Continue to
[Configuration](../configuration/index.md).
