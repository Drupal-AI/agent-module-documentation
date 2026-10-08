# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **PHP 8.1** or newer.
- No third‑party Composer packages or contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_data -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_data -y
```

## Verify it worked

Entity Data has no visible UI. Confirm the `entity.data` service is available — for
example from Drush:

```bash
drush php:eval "var_dump(\Drupal::hasService('entity.data'));"
```

A `true` result means the service is registered and ready to be used from your
module code.
