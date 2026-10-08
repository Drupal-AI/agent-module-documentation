# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Views** module (`views`) enabled — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

The project's machine name is `first_assign_vira`, so that's the Composer package
name (even though the module presents itself as "Entity Auto Term"). From the
project root:

```bash
composer require drupal/first_assign_vira -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/first_assign_vira -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The internal module name is `eat`, so enable it with:

```bash
drush en eat -y
```

## Verify it worked

Visit **Configuration → System → Entity Auto Term** (`/admin/config/system/eat`).
You should see the settings form for mapping entity/bundle combinations to
vocabularies. Continue to [Configuration](../configuration/index.md) to set up your
first mapping and, if needed, backfill existing content.
