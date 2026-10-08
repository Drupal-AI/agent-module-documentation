# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- An administrative toolbar to render into — core's **Toolbar** module or the
  newer **Navigation** module. The project references both as test dependencies,
  so it works with either shell.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_messages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_toolbar_messages -y
```

There is no configuration step. Once enabled, status messages appear in the
toolbar site-wide. See the [overview](../index.md) for how to test it and the two
accessibility checks worth doing.
