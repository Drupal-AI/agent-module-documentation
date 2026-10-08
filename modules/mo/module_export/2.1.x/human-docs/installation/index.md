# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`). Note that this
  release line does **not** declare Drupal 11 support.
- No PHP version constraint beyond what your Drupal core requires.
- **No third‑party module or library dependencies.**

## Install with Composer

From the project root:

```bash
composer require drupal/module_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_export -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_export -y
```

## Verify it worked

Log in as a user with the **Administer users** permission and go to
**`/admin/modules/export`**. You should see the export form, where you can choose
your options and generate a glue module or CSV. See "How to use it" in the
[overview](../index.md) for the full round‑trip.
