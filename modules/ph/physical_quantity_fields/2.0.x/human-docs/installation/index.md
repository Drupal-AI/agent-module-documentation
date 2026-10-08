# Installation

## Requirements

Physical Quantity Fields needs:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer.**
- Core's **Field** module (`field`), which is part of a standard Drupal install.

There are no third‑party Composer library requirements. Installing via Composer
handles the module's class mapping and service registration automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/physical_quantity_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/physical_quantity_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en physical_quantity_fields -y
```

## Upgrading from 1.x

Version 2.x is fully backward compatible with 1.x data and ships automated
configuration migrations, so existing fields carry over without manual data
fixes when you update.

## Verify it worked

Go to any content type's **Manage fields**, click **Add field**, and confirm the
physical‑quantity field types (Length, Mass, Temperature, and the rest) appear in
the list. Add one, pick a display unit on **Manage display**, and check that a
sample value renders in the unit you chose — see "How to use it" in the
[overview](../index.md) for the full walk‑through.
