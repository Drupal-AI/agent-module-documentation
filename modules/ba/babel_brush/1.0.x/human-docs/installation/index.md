# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Locale** module (`locale`), which Babel Brush builds on. Drupal enables it
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/babel_brush -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/babel_brush -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Note:** this is an alpha release. Test it on a non‑production environment, and back
> up before cleaning up translations in bulk.

## Enable the module

```bash
drush en babel_brush -y
```

This enables Locale too if it wasn't already on. Grant the `administer babel brush
search form` permission to the users who will use the cleanup tools.
