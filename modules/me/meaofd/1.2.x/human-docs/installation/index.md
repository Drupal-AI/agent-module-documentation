# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules and no third-party libraries — it builds entirely on core's
  entity-definition update system.

## Install with Composer

From the project root:

```bash
composer require drupal/meaofd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meaofd -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meaofd -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

There is nothing to configure. The report appears under **Reports → Mismatched entity
and/or field definitions**, and the `drush meaofd:fix` command becomes available. See
the [overview](../index.md#how-to-use-it) for the three ways to clear a mismatch. Do
not forget to grant the **Fix** permission to whichever role should be allowed to
apply fixes.
