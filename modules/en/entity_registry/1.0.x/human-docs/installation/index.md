# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.1** or newer — the module discovers consumer plugins via PHP attributes,
  which require 8.1+.
- No contrib dependencies and no submodules.
- Optional: the **Ultimate Cron** module (`drupal/ultimate_cron`) if you want
  finer-grained control over how often asynchronous processing runs on cron.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_registry -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_registry -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_registry -y
```

On its own, Entity Registry tracks nothing useful until a **consumer plugin** exists
(written by you or provided by another module). See the [overview](../index.md) for a
consumer skeleton, and [Configuration](../configuration/index.md) for the dashboard,
settings, permission, and Drush commands.

> After adding or changing a consumer plugin, run `drush cr` so it's discovered.
