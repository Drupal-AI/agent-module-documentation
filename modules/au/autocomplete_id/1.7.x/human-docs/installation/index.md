# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core, and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_id -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autocomplete_id -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_id -y
```

## After enabling

Grant the **View entity autocomplete id results** permission to the roles that
should see ID-based suggestions, then turn on ID matching either per field or
globally. Both approaches are covered in
[How to use it](../index.md#how-to-use-it) on the overview page.
