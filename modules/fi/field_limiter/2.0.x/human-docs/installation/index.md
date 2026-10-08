# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contrib **Field Formatter** module (`field_formatter`) — Field Limiter is built on the
  wrapping‑formatter base class this module provides, so it's a hard dependency. Composer
  pulls it in automatically.

There are no other third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_limiter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Field Formatter
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_limiter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable Field Limiter together with its Field Formatter dependency:

```bash
drush en field_formatter field_limiter -y
```

(Enabling `field_limiter` alone will also pull in `field_formatter` as a dependency, but
listing both makes the requirement explicit.)

## Next step

There is no configuration form. Head to the [overview](../index.md) for how to apply the
limiter to a field on the **Manage display** tab.
