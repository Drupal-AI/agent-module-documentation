# Installation

## Requirements

Field Menu needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field UI** module enabled if you want to add the field through the admin
  interface (this is standard on most sites). Field Menu itself lists no module
  dependencies.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/field_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_menu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_menu -y
```

There is no settings page to visit and no permissions to grant. Once enabled, a
**Menu item** field type is available to add to any fieldable entity.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Go to **Structure → Content types → (any type) → Manage fields → Add field** and
confirm **Menu item** appears in the field‑type list. See the
[overview](../index.md#how-to-use-it) for how to configure and place it.
