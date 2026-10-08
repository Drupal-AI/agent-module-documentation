# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install
  and is enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_list -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autocomplete_list -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_list -y
```

The module ships no submodules. Once enabled, the **Autocomplete (List style)**
widget becomes available to select on any bundle's **Manage form display** screen —
see [How to use it](../index.md#how-to-use-it).
