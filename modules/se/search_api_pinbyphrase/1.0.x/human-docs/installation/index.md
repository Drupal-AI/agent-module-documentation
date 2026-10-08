# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Search API** module (`search_api`).
- The **Search API Solr** module (`search_api_solr`) — required. The module is
  expected to work on a "content" index served by Solr.

There are no third-party Composer or PHP library requirements beyond the modules
above.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_pinbyphrase -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_pinbyphrase -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_pinbyphrase -y
```

This also enables Search API and Search API Solr if they aren't already on.

## Verify it worked

Go to **Extend** (`/admin/modules`), find **Search API PinByPhrase** in the list,
and click its gear/settings icon — that takes you to the configuration form where
you'll set up your pinned phrases. See [Configuration](../configuration/index.md).
