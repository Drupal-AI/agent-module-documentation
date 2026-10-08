# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies — it works against core's field system alone.

There are no third‑party Composer or PHP library requirements, and no external
JavaScript libraries; the toggle behavior is built on core's own `once` and `drupal`
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/expand_collapse_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expand_collapse_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expand_collapse_formatter -y
```

The module has no settings page and ships no submodules. Once enabled, the
**Expand collapse formatter** format is available for long‑text fields on any entity's
Manage display screen — see [How to use it](../index.md#how-to-use-it) on the overview
page.
