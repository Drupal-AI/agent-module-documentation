# Installation

## Requirements

htmx targets modern Drupal because it relies on the HTMX library that ships with
core:

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`). Core provides the
  `core/htmx` library from 11.2, which this module builds on.
- **PHP 8.3 or newer** (`php: ^8.3`). Composer will refuse to install the module
  on an older PHP.

There are no other module dependencies and no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/htmx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Composer reports a conflict, check that your site is on
Drupal 11.2+ and PHP 8.3+ first.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/htmx -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htmx -y
```

Once enabled you can start using `create_htmx()` in Twig/PHP and managing HTMX
blocks at `/admin/structure/htmx-block` — see [the index page](../index.md).

## Optional submodule — htmx_debug

The module ships one submodule, **htmx_debug**, which swaps in the unminified
HTMX library and logs events to the browser console. Enable it while developing:

```bash
drush en htmx_debug -y
```

Leave it off (or uninstall it) in production.
