# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** module (`field`) enabled — Drupal enables it automatically as a
  dependency. To add or manage the field through the UI you will also want the core
  **Field UI** module enabled.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link -y
```

Once enabled, a new **Menu link** field type becomes available when you add a field
to any bundle. See [Configuration](../configuration/index.md) for how to add and set
up the field.
