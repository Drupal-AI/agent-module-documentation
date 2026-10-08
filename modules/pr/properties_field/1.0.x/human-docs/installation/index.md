# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/properties_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/properties_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en properties_field -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and start adding a
new field. If **Properties** appears in the field‑type list, the module is installed
and ready. See "How to use it" on the [overview page](../index.md) for the field setup
steps.
