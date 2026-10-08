# Installation

## Requirements

Search API Field Datasource needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3** or newer.
- **Search API** (`search_api`).

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_field_datasource -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/search_api_field_datasource`) matches the module's machine name
(`search_api_field_datasource`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_field_datasource -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_field_datasource -y
```

Enabling the module makes the **"Field keyed"** data sources available when you
create a Search API index. See
[How to use it](../index.md#how-to-use-it) in the main guide.

## Verify it worked

Create or edit a Search API index and confirm that a **"Field keyed"** entity data
source appears among the datasource options.
