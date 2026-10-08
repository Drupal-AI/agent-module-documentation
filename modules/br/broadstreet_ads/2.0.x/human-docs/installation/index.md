# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — Broadstreet Ads depends on it and Drupal
  enables it automatically as a dependency.
- A **Broadstreet publisher account** with the ad zone IDs you want to display.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/broadstreet_ads -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/broadstreet_ads -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en broadstreet_ads -y
```

Core Block is enabled automatically if it is not already on. Next, register your
zones and place the blocks — see [Configuration](../configuration/index.md).
