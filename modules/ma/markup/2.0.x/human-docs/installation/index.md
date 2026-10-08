# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is enabled on any standard Drupal
  site and is pulled in as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/markup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/markup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markup -y
```

There are no submodules and no configuration to do at the module level. Once
enabled, the **Markup** field type appears in Field UI's "Add field" list — see
the [overview](../index.md) for how to add and fill it.
