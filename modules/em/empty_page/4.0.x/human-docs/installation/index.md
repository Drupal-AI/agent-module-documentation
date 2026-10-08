# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core, and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/empty_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/empty_page -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en empty_page -y
```

Once enabled, create your first blank page under **Structure → Empty Page** and
grant the **View empty pages** permission, as described in the *How to use it*
section on the [overview page](../index.md). There are no submodules.
