# Installation

## Requirements

- **Drupal 9.1 or newer** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Nothing else — the module relies only on Drupal core's flood service, with no
  contributed dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/protect_form_flood_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/protect_form_flood_control -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protect_form_flood_control -y
```

## Next steps

Out of the box the module protects nothing (the default mode protects only an empty
list of forms). Head to [Configuration](../configuration/index.md) to choose which
forms to protect and set your threshold and window.
