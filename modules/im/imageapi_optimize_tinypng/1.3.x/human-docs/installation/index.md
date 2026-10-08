# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **ImageAPI Optimize** module (`drupal/imageapi_optimize`) — this provides the
  pipeline system that TinyPNG plugs into. Composer pulls it in and Drupal enables it
  as a dependency.
- The **Tinify PHP library** (`tinify/tinify`, `^1.5`) — Composer installs this for
  you. (If it's ever missing, Drupal's status report flags an error.)
- A **TinyPNG account and API key** from <https://tinypng.com>.

## Install with Composer

From the project root:

```bash
composer require drupal/imageapi_optimize_tinypng -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the ImageAPI Optimize
dependency and the Tinify library and update any shared packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imageapi_optimize_tinypng -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imageapi_optimize_tinypng -y
```

Drupal enables **ImageAPI Optimize** at the same time as a dependency.

There are no submodules and no permissions of its own. After enabling, continue to
[Configuration](../configuration/index.md) to add the TinyPNG processor to a pipeline
and enter your API key.
