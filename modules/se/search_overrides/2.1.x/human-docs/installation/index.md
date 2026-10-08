# Installation

## Requirements

- **Drupal 9.2+, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **Search API** (`search_api`) and **Search API Solr** (`search_api_solr`,
  version `4.2.4` or newer). Composer pulls in Search API Solr automatically, and
  Drupal enables both as dependencies.
- A **working Solr server** with a Search API Solr index. The overrides use
  Solr's native elevate/exclude query parameters, so a Solr backend is essential
  — the module does nothing on the database backend.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_overrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API Solr
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/search_overrides -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_overrides -y
```

This enables Search API and Search API Solr as dependencies if they are not
already on.

## Next step

Configure the global options and create your first override — continue to
[Configuration](../configuration/index.md).
