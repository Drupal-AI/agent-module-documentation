# Installation

## Requirements

Fallback Formatter is deliberately lightweight:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No other module dependencies, no third-party Composer libraries, and no PHP
  extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fallback_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fallback_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fallback_formatter -y
```

That's all. There is no settings page and no submodules. The new **Fallback**
formatter is now available on any field (with two or more formatters) at
**Structure → *(entity type)* → Manage display** — see the
[overview](../index.md#how-to-use-it) for how to configure it on a field.
