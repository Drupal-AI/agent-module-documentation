# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No third‑party Composer packages, PHP libraries, or contrib module
  dependencies.

The formatter is intended for **entity reference fields** with multiple items,
though it selects items by delta on a multi‑value field.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_delta_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_delta_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_delta_formatter -y
```

## Verify it worked

Go to **Structure → (an entity type) → Manage display** for a bundle that has a
multi‑value field, and confirm that **"Rendered entities by delta"** appears as an
available format. Selecting it and entering a delta (for example `1`) should limit
the rendered output to just that item.
