# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

That's the whole list. Field Count Formatter has no module dependencies beyond
Drupal core, no third‑party Composer or PHP libraries, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/field_count_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_count_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_count_formatter -y
```

There is no configuration step. Once enabled, **Field count** is available in the
**Format** select on every field's **Manage display** tab.

## Verify it worked

Open the **Manage display** tab of an entity that has a multi‑value field, set
that field's **Format** to **Field count**, and view the entity. The field should
show a number (the count of values) instead of its contents. See the
[overview](../index.md) for the details.
