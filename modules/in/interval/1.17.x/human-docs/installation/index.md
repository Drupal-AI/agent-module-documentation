# Installation

## Requirements

Interval Field is lightweight:

- **Drupal 10.5, 11.3, or 12** (`core_version_requirement: ^10.5 || ^11.3 || ^12.0`).
- Core's **Field** module (`field`), which is part of the standard Drupal install and
  is enabled automatically as a dependency.
- No third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/interval -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/interval -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en interval -y
```

Once enabled, **Interval** appears as a choice when you add a field to any entity
type. See the [main page](../index.md#how-to-use-it) for adding a field, restricting
the available periods, and choosing a display formatter.
