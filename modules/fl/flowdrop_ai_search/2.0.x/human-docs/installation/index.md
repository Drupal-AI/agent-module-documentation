# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **FlowDrop** (`flowdrop`) and its node modules (`flowdrop_node_type`,
  `flowdrop_node_category`) — the workflow engine and its node categorisation.
- **AI** (`ai`) and **AI Search** (`ai_search`) — the provider abstraction and the
  vector‑search integration.
- **Search API** (`search_api`) — the indexing framework the Search API backend mode
  builds on.

You will also need a vector‑database provider (for example Milvus, Pinecone, or
Postgres) configured through the AI Search stack, plus an AI provider with a valid API
key for generating embeddings. There are no extra Composer library or PHP version
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_ai_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the FlowDrop, AI,
AI Search, and Search API dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_ai_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_ai_search -y
```

Drupal will enable the required FlowDrop, AI, AI Search, and Search API modules as
dependencies if they are not already on.

## Verify it worked

Open a FlowDrop workflow in the editor and look for the **AI Search** category in the
sidebar, containing the **VDB Search** node. If the category or node is missing,
confirm `ai_search` and `search_api` are enabled and that you have at least one vector
database backend configured.
