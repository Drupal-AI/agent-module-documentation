# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- No module dependencies beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/field_compare -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_compare -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_compare -y
```

## Verify it worked

Grant the **"access field compare"** permission to your role, then visit
**Reports → Field compare** (`/admin/reports/field-compare`). You should see the
report and be able to pick an entity type to compare. See the
[overview](../index.md#how-to-use-it) for how to read and configure it.
