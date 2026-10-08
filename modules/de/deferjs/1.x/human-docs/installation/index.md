# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies, and no PHP library or third‑party Composer
requirements — the deferjs JavaScript library ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/deferjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/deferjs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en deferjs -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Performance
→ Defer JS** (`/admin/config/performance/deferjs`). If the settings form loads,
the module is active. After adjusting the settings (see
[Configuration](../configuration/index.md)), load a front‑end page and test your
site's interactive features to confirm the deferred scripts still work as
expected.
