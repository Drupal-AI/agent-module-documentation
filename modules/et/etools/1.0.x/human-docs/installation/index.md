# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no contrib module dependencies and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/etools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/etools -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en etools -y
```

There is no configuration to do — the utilities are available once the module is
enabled.

## Verify it worked

Confirm the module is listed as enabled under **Extend** (`/admin/modules`) or with
`drush pml | grep etools`. From there, its helper utilities and plugins are ready
to use in your development work.
