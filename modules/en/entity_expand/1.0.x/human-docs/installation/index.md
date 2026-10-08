# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7 or 8** (`^7 || ^8.0`).
- No other module dependencies and no third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_expand -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_expand -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_expand -y
```

## Verify it worked

There is no admin page to check. Once enabled, the `entity_expand_load()` and
`_entity_load()` functions are available to your custom code, and you can extend
`Drupal\entity_expand\EntityExpandBase` and implement
`hook_entity_expand_load()`. See the parent [guide](../index.md) for how to wire
those up.
