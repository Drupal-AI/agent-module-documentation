# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Image Optimize / ImageAPI Optimize** (`drupal/imageapi_optimize`) — this
  module provides a processor *for* that pipeline system, so it is a hard
  dependency. Composer pulls it in automatically.
- Outbound network access at optimize time, so the site can reach the reSmush.it
  API (`api.resmush.it`).

There are no third‑party Composer packages beyond the `imageapi_optimize`
dependency.

> **Heads up:** the current release is a **beta** (`2.1.0-beta1`). Test it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/imageapi_optimize_resmushit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in `drupal/imageapi_optimize`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imageapi_optimize_resmushit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imageapi_optimize_resmushit -y
```

Drupal enables the required **Image Optimize** module at the same time. After
enabling, add the reSmush.it processor to an Image Optimize pipeline and attach
that pipeline to your image styles — see
[How to use it](../index.md#how-to-use-it) on the overview page.

There are no submodules.
