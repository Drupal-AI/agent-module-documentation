# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **Search API** module (`search_api`).
- The **Search API OpenSearch** module (`search_api_opensearch`) — this module is
  an extension of it.
- An **OpenSearch 3.1+** cluster, since the feature relies on the semantic field
  introduced in OpenSearch 3.1.
- An **ML model integrated in OpenSearch**, set up outside this module, whose model
  ID you can supply in the settings. See OpenSearch's "Integrating ML models"
  documentation.

This is an experimental, under-active-development module that assumes familiarity
with configuring OpenSearch to use ML models. There are no third-party Composer or
PHP library requirements beyond the modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_opensearch_semantic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_opensearch_semantic -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_opensearch_semantic -y
```

This also enables Search API and Search API OpenSearch if they aren't already on.
Once enabled, continue to [Configuration](../configuration/index.md).
