# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other contrib modules are required. The module ships its own JavaScript
  library (`search_tracking/form-api-data`).

> **Note:** the module's stable release is **not covered** by Drupal's security
> advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/search_tracking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_tracking -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_tracking -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search Tracking → Form config**
(`/admin/config/search/search-tracking/form-config`) as an administrator — the form
configuration page should load. Nothing is tracked until you enter the correct form
attributes there; see [Configuration](../configuration/index.md).
