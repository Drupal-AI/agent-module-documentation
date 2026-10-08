# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Nothing else — no contrib module dependencies, and no third‑party PHP or
  JavaScript libraries. The ISO 4217 data is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/currency_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/currency_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en currency_field -y
```

## Verify it worked

On a content type, go to **Manage fields → Add field** and confirm that
**Currency** appears as an available field type. Add it, and check that the select
widget lists ISO 4217 currencies.
