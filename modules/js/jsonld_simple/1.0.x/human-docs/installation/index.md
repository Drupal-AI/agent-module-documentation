# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonld_simple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonld_simple -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonld_simple -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
JSON-LD Simple** (`/admin/config/search/jsonld-simple/settings`). If the settings
form loads, the module is installed and ready to configure — see
[Configuration](../configuration/index.md).
