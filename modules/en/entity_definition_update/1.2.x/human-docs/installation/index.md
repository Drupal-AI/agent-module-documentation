# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **System** (`system`) and **Field** (`field`) modules — both are part of
  standard Drupal installs and enabled as dependencies.
- No third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_definition_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_definition_update -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_definition_update -y
```

## Verify it worked

The module has no UI. Confirm its service is registered — for example from Drush:

```bash
drush php:eval "var_dump(\Drupal::hasService('entity_definition_update.entity_definition_update_manager'));"
```

A `true` result means the update manager service is available to call from your
`hook_install()` / `hook_update_N()` code. Before running any real definition update,
**back up your database** and rehearse the update on a non‑production copy.
