# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) and its **AI Search** submodule (`ai_search`) — the
  search/RAG layer this provider plugs into.
- The **Key** module (`key`) — used to store the Azure API key as a secret.
- The **Search API** module (`search_api`) — AI Search is built on it.
- An **Azure AI Search** service that you have provisioned in the Azure portal.
  You will need its **endpoint URL** and an **API key** (admin key). The vector
  store itself is Microsoft's managed service — nothing runs on your own server.

The AI, AI Search, Key, and Search API modules are enabled automatically as
dependencies when you turn this module on.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_azure_ai_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the AI,
Key, and Search API dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_vdb_provider_azure_ai_search -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_azure_ai_search -y
```

Enabling it only registers Azure AI Search as an available vector database. Next,
store your Azure key and connect it to AI Search — see
[Configuration](../configuration/index.md).
