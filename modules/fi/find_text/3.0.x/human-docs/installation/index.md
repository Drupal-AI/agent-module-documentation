# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module, which Drupal enables automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/find_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/find_text -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en find_text -y
```

Or enable **Find Text** from *Extend* (`/admin/modules`).

There are no submodules. After enabling, grant the two restricted permissions to
trusted roles:

- **Access find text** — use the search form at `/admin/find-text`.
- **Administer find text configuration** — change the settings at
  `/admin/config/find-text/settings`.

Then start searching — see [Configuration](../configuration/index.md).
