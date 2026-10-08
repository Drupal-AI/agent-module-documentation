# Installation

## Requirements

Views Fields On/Off is self‑contained:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module enabled (part of core) — this is where you add the
  handlers.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_fields_on_off -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_fields_on_off -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_fields_on_off -y
```

There are no submodules and no configuration form. Once enabled, the **Global:
On/Off Form** field and **Global: On/Off Filter** filter become available to add
inside any View — see the [overview](../index.md) for how to configure them.
