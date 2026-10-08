# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Commerce License** (`commerce_license`) — the licensing framework this license
  type plugs into (which requires a working Drupal Commerce installation).
- **Dynamic Entity Reference** (`dynamic_entity_reference`) — lets a single license
  field target different entity types.

Drupal will pull these dependencies in when you install the module with Composer.

> **Note:** This is an alpha release (`8.x-2.0-alpha7`), the module is declared
> **incomplete** by its maintainers, and the project is marked *not covered* by
> Drupal's security advisory policy. Treat it as a development starting point and
> test thoroughly before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_license_entity_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (Commerce License, Dynamic Entity Reference) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_license_entity_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_license_entity_field -y
```

This also enables Commerce License and Dynamic Entity Reference if they are not
already on.

## Verify it worked

On a license‑enabled Commerce product variation, edit its license field: the
**Entity field** (`entity_field`) license type should now be selectable. See the
"How to use it" section of the [overview](../index.md) for configuring it — and
keep in mind the module is unfinished, so a production deployment will require
custom code.
