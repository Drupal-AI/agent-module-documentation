# Installation

> **Before you install:** Denormalizer **creates databases and performs
> destructive operations on tables and views**. Back up first and review the
> warning in the [overview](../index.md).

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no other module dependencies, and no PHP library or third‑party
Composer requirements. To *use* it you will need a custom module in which to
implement `hook_denormalizer_info()` (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/denormalizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/denormalizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en denormalizer -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Denormalizer**
(`/admin/config/development/denormalizer`). If the settings page loads, the module
is active. It will not do anything until you describe what to denormalize in code
and then build it from the admin UI — see [Configuration](../configuration/index.md).
