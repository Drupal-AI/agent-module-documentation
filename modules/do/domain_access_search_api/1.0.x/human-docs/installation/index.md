# Installation

## Requirements

Domain Access Search API is a bridge module, so it needs the two projects it
bridges already in place:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **[Domain](https://www.drupal.org/project/domain) 2.x or 3.x**, with its
  **Domain Access** submodule (`domain_access`) enabled — this is what provides
  the `field_domain_access` field on your content.
- **[Search API](https://www.drupal.org/project/search_api) 1.38 or newer**
  (`drupal/search_api:^1.38`), with at least one index configured.

Composer pulls Domain and Search API in for you when you require this module.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_access_search_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_access_search_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_access_search_api -y
```

Drupal enables `search_api`, `domain`, and `domain_access` as dependencies if they
are not already on. There is no configuration form to visit afterward — head to
[Configuration](../configuration/index.md) to wire the filter into your index and
view.
