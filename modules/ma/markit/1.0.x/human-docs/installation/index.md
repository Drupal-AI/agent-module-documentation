# Installation

## Requirements

- **Drupal 10.2 or later, or 11** (`core_version_requirement: ^10.2 || ^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies. (The HTTP endpoints work without the core REST module, though
  enabling REST can change some responses.)

## Install with Composer

From the project root:

```bash
composer require drupal/markit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markit -y
```

## Verify it worked

At **Extend** (`/admin/modules`) confirm **MarkIt** is checked, then go to
**Structure → MarkIt** to start creating your mark types. See
[Configuration](../configuration/index.md) for the full setup routine.
