# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Search API** module (`search_api`).
- A running **Meilisearch instance** that Drupal can reach. Setting up the
  Meilisearch server is done outside this module — see the official Meilisearch
  documentation for the options. The 2.x series of this module targets the
  Meilisearch 1.3.x line (and 1.4+) via the `meilisearch-php` 1.3 client.
- *(Optional)* the **Search API Autocomplete** module if you want the autocomplete
  feature, and the **Facets** module if you want faceted search.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_meilisearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the `meilisearch-php` client library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_meilisearch -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_meilisearch -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds | Also needs |
|-----------|--------------|--------------|------------|
| **Autocomplete** | `search_api_meilisearch_autocomplete` | Search-as-you-type autocomplete for your search box. | Search API Autocomplete module |
| **Facets** | `search_api_meilisearch_facets` | Faceted search on your Meilisearch index. | Facets module |

For example, to add faceted search:

```bash
drush en search_api_meilisearch_facets -y
```

Once enabled, continue to [Configuration](../configuration/index.md).
