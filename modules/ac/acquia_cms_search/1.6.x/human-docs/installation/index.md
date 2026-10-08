# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Common** (`acquia_cms_common`) — the shared Acquia CMS layer.
- **Search API** with its database backend (`search_api_db`), plus **Search API
  Autocomplete** (`search_api_autocomplete`).
- **Facets** (`facets`) and **Facets Pretty Paths** (`facets_pretty_paths`).
- **Collapsiblock** (`collapsiblock`) — collapsible facet blocks.
- Core **Node** (`node`) and **Views** (`views`).
- **A configured search index/server must be present.** In the full Acquia CMS
  distribution this is Solr. The module will not enable cleanly if the index it
  references is missing, so set up the search server as part of installing this
  module (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API,
Facets, and the other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_search -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_search -y
```

Drush enables the dependencies automatically. If enabling fails, the most likely
cause is a missing search index/server that the shipped configuration expects —
see [Configuration](../configuration/index.md) to get the Search API server in
place first.
