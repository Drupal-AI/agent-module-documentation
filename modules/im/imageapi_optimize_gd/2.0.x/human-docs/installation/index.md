# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **ImageAPI Optimize** module (`drupal/imageapi_optimize`) — this is a hard
  dependency; the GD processor plugs into its pipelines. Composer pulls it in
  automatically with `-W`.
- **PHP compiled with the GD extension** (the same GD most Drupal sites already
  use for image processing). Without it the processor logs a notice and does
  nothing.

There are no third-party Composer or PHP library requirements beyond GD, and — by
design — **no command-line optimizer binaries** are needed.

## Install with Composer

From the project root:

```bash
composer require drupal/imageapi_optimize_gd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**ImageAPI Optimize** module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imageapi_optimize_gd -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependency (Drush enables ImageAPI Optimize
automatically as a requirement):

```bash
drush en imageapi_optimize_gd -y
```

There are no submodules. Enabling the module makes a new **GD** processor
available to add to your Image Optimize pipelines — see
[Configuration](../configuration/index.md) to set it up.
