# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI** module (`ai`) and its **AI Search** layer (version ^1.2) — the
  search/RAG layer this provider plugs into.
- The **OpenAI provider** module (`ai_provider_openai`), installed and configured
  with a working OpenAI API key. This provider owns the OpenAI connection and the
  key that this module reuses.
- The **Key** module (`key`) — the OpenAI API key is stored as a Key, backed by an
  environment variable.
- An **OpenAI account and API key** with access to the embeddings/vector features
  you intend to use. The vector store is OpenAI's service; nothing runs on your
  own server.

The AI module, the OpenAI provider, and Key are enabled automatically as
dependencies when you turn this module on.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_openai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the AI,
OpenAI provider, and Key dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_vdb_provider_openai -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_openai -y
```

Enabling it registers OpenAI as an available vector database. Next, confirm the
OpenAI key is in place and select OpenAI as the AI Search vector database — see
[Configuration](../configuration/index.md).
