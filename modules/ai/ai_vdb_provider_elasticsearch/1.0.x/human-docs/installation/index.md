# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) and its **AI Search** submodule (`ai_search`) — the
  search/RAG layer this provider plugs into.
- The **Key** module (`key`) — used to store the Elasticsearch credentials as a
  secret.
- The **Search API** module (`search_api`) — AI Search is built on it.
- A running **Elasticsearch cluster** you can reach over the network, with its
  address and credentials. You provision and secure the cluster yourself; this
  module does not install Elasticsearch.

The AI, AI Search, Key, and Search API modules are enabled automatically as
dependencies when you turn this module on.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_elasticsearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the AI,
Key, and Search API dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_vdb_provider_elasticsearch -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_elasticsearch -y
```

Enabling it only registers Elasticsearch as an available vector database. Next,
store your cluster credentials and connect them to AI Search — see
[Configuration](../configuration/index.md).
