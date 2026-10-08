# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Nothing else — the module has **no dependencies** beyond Drupal core, no
  third‑party libraries, and no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/condition_query -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/condition_query -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en condition_query -y
```

There are no submodules and no configuration form. The **Request Param**
condition is immediately available under any block's **Visibility** settings (and
anywhere else Drupal conditions apply) — see the [overview](../index.md) for how
to use it.
