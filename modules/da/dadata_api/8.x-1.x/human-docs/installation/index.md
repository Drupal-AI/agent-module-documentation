# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A **DaData account and API token** — sign up at
  [dadata.ru](https://dadata.ru/) (free and paid tiers exist).
- No module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dadata_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dadata_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dadata_api -y
```

## Verify it worked

Open the DaData API settings form (the `dadata_api.settings` route, in the
Configuration area) and confirm it loads. Enter your DaData token to connect —
see [Configuration](../configuration/index.md).
