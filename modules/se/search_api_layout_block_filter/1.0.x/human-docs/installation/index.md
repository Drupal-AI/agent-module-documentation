# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`).
- The core **Layout Builder** module (`layout_builder`).

Drupal will pull in these dependencies automatically when you enable the module.
There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_layout_block_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_layout_block_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_layout_block_filter -y
```

Once enabled, continue to [Configuration](../configuration/index.md) to choose
which blocks to exclude — the module does nothing until you configure and enable
its filter.
