# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- The **Search API** module (`search_api`).
- A running **TruSearch engine instance** with a valid API key and tenant ID —
  this external service is where the actual searching and AI processing happens.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_trusearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_trusearch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_trusearch -y
```

## Verify it worked

After enabling, go to **Configuration → Search and metadata** — you should see a
**TruSearch Settings** entry. The module is installed but not yet functional:
follow [Configuration](../configuration/index.md) to enter your engine
credentials and connect a Search API server and index before search will work.
