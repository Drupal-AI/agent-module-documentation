# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API** module (`search_api`).
- The **jQuery UI Autocomplete** module (`jquery_ui_autocomplete`), used by the
  instant-search autocomplete block.

Drupal will enable these dependencies automatically. There are no third-party
Composer or PHP library requirements — Lunr itself runs in the browser.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_lunr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_lunr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_lunr -y
```

Once enabled, continue to [Configuration](../configuration/index.md) to create a
Lunr server and index.
