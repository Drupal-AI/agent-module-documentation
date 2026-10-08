# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  Note the caveat about visual correctness on newer core versions in the
  [overview](../index.md).
- The **Admin Toolbar** module (`admin_toolbar`) must be installed and enabled —
  this skin restyles it and does nothing on its own. Composer pulls it in
  automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_mediteran -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including pulling in Admin Toolbar — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_mediteran -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_toolbar_mediteran -y
```

Drupal enables the base Admin Toolbar module at the same time if it is not already
on. The new styling applies immediately — there is no configuration step. Reload
any admin page to see the Mediteran toolbar.
