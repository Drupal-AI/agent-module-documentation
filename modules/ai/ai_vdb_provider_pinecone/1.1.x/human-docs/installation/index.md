# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The Drupal **AI** module (`drupal/ai`, ^1.1) and its **AI Search** submodule (`ai_search`).
- The **Search API** module (`search_api`) — AI Search builds on it.
- The **Key** module (`drupal/key`, ^1.18) — used to hold the Pinecone API key securely.
- The **`scotteuser/pinecone-php`** PHP SDK (^1.0.2), which talks to Pinecone's API. Composer
  installs it automatically.
- A **Pinecone account** with an API key and at least one serverless index.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_pinecone -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI module, Key, Search API and the
`scotteuser/pinecone-php` library, updating shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/ai_vdb_provider_pinecone -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable the provider along with the AI Search stack and Key:

```bash
drush en ai_vdb_provider_pinecone ai_search search_api key -y
```

(Enabling `ai_vdb_provider_pinecone` will bring in `ai` and its dependencies; the command
above just makes sure the search side and Key are on too.)

## Next: connect Pinecone

Before the provider can do anything it needs your Pinecone API key, stored as a **Key
entity**, and you then select Pinecone as the vector database on an AI Search index. Both
steps are covered on the [Configuration](../configuration/index.md) page.
