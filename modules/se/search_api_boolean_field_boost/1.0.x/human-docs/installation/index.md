# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- The **Search API** module (`search_api`) — this module adds a processor to Search
  API, so it depends on it.
- A backend that honours Search API boost factors (for example Solr or the database
  backend).
- No third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_boolean_field_boost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_boolean_field_boost -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_boolean_field_boost -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), open a search index, and switch to the
**Processors** tab. If **Boolean Field Boost** appears in the list of available
processors, the module is active. See
[How to use it](../index.md#how-to-use-it) in the main guide to configure the boost —
remember to re-index afterwards so the boost is applied.
