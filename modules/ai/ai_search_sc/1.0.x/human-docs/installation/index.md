# Installation

## Requirements

- **Drupal 11.1+** (`core_version_requirement: ^11.1`) — note this module does *not*
  support Drupal 10.
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`), configured with a
  provider that offers **embeddings** (the strategy needs embeddings to decide
  where to split).
- **[AI Search](https://www.drupal.org/project/ai_search)** (`ai_search`) — this
  module extends it and does nothing on its own.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_search_sc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the AI
and AI Search modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_search_sc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_search_sc -y
```

Enabling it also enables the AI and AI Search modules if they are not on yet. The
module ships no submodules.

## After enabling

There is no separate settings page. Edit your AI Search server or index
configuration under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and choose **semantic chunking** as the
chunking strategy, then reindex so existing content is re-chunked. See the
[overview](../index.md) for how it fits with AI Search.
