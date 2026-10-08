# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core **Field** (`field`) and **Block** (`block`) modules enabled — these are the
  only dependencies and Drupal enables them as needed.

> **Note:** The AddThis third-party service was discontinued by its vendor in 2023,
> so the share buttons will not work on a live site today. See the
> [overview](../index.md) before investing setup time.

## Install with Composer

From the project root:

```bash
composer require drupal/addthis_social_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addthis_social_share -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addthis_social_share -y
```

There are no submodules. After enabling, configure the buttons and place the block
— see [Configuration](../configuration/index.md).
