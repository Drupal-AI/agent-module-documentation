# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, and no extra PHP library requirements.

There is nothing else to install alongside it.

## Install with Composer

From the project root:

```bash
composer require drupal/optimize_config_storage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/optimize_config_storage -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optimize_config_storage -y
```

The active config storage is swapped automatically as soon as the module is enabled
— there is no configuration step.

## Verify it worked

Rebuild caches (`drush cr`) and load a page on a cold cache. If you have query
logging or an APM in place, you should see the config reads collapse into a single
config‑table query rather than one query per object. To revert, uninstall the module
and Drupal returns to its default config storage.
