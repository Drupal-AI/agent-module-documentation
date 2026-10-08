# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- **Entity Share** 3.x (`drupal/entity_share ^3.0`), with its **Entity Share Client**
  submodule (`entity_share_client`) enabled — this is where Set Author plugs in.

## Install with Composer

From the project root:

```bash
composer require drupal/set_author -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in `drupal/entity_share` if it isn't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/set_author -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure the Entity Share Client submodule is on, then enable Set Author:

```bash
drush en entity_share_client -y
drush en set_author -y
```

Enabling Set Author adds the **Set author** processor to Entity Share Client, but does
nothing until you turn it on for a specific import config. See the
[overview](../index.md#how-to-use-it) for the per-import-config steps and the two
settings.
