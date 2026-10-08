# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **Path alias** module (`path_alias`) — the only dependency, and part of
  core. Drupal enables it automatically as needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/path_watcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_watcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_watcher -y
```

## Verify it worked

Visit a few pages on the site, then go to **Configuration → System → Path Watcher**
(`/admin/config/system/path-watcher`) to confirm the settings form loads and that
visits are being recorded. Next, head to
[Configuration](../configuration/index.md) to tune what is recorded, place the
visits block, and grant the statistics permission to the right roles.
