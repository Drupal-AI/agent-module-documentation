# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, PHP extensions or third-party Composer libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/accessibility_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/accessibility_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en accessibility_block -y
```

Then place the block in a region of your theme — see the
[main guide](../index.md#how-to-use-it).
