# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.

> **Compatibility note:** No Table Drag overrides the theme registry callback
> for the tabledrag theme function. If your theme or site depends on a custom
> multi-field theme override, it may conflict with this module — test before
> deploying to production.

## Install with Composer

From the project root:

```bash
composer require drupal/no_table_drag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/no_table_drag -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en no_table_drag -y
```

## Verify it worked

Open the **Manage form display** for a bundle that has a multi-value field, open
that field's widget settings, and confirm the **No Table Drag** (`#nodrag`)
option is available. Enable it, save, then edit a node — the field's rows should
appear without drag handles.
