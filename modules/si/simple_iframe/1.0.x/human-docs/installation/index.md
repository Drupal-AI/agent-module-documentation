# Installation

## Requirements

Simple IFrame is intentionally minimal. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) enabled — this is the only dependency, and it
  is part of core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_iframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_iframe -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_iframe -y
```

That is all it takes. There is no configuration form to visit. Once enabled, the
**Simple IFrame** field type becomes available when you add a field to any bundle —
see the [overview](../index.md) for how to add and use the field.
