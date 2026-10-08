# Installation

## Requirements

Search API Date Boost needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Search API** (`search_api`).
- **Search API Database** (`search_api_db`) — the module is designed for the
  Database backend, and Search API DB Defaults is the companion the project
  references for a working out-of-the-box setup.

There are no third-party Composer libraries or PHP extensions required.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_date_boost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/search_api_date_boost`) matches the module's machine name
(`search_api_date_boost`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_date_boost -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_date_boost -y
```

Enabling the module makes the **Date field-based boosting** processor available.
It does nothing until you turn it on for an index and configure it — see
[Configuration](../configuration/index.md).

## Verify it worked

Edit a Search API index that uses the Database backend, open the **Processors**
tab, and confirm that **Date field-based boosting** appears in the list of
available processors.
