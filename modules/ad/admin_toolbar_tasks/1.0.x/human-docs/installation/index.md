# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`), which Drupal enables automatically as a
  dependency when you turn this module on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_tasks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_toolbar_tasks -y
```

There is no configuration step. Once enabled, administrative local tasks appear in
the toolbar site-wide. See the [overview](../index.md) for what to test — remember
to test as an editor, not as user 1.
