# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Type Tray** module (`drupal/type_tray` `^1.2`) — a hard dependency; this
  module themes Type Tray's output.
- The **Gin** admin theme (`drupal/gin` `^3 || ^4 || ^5`) installed and set as your
  administration theme — the Gin styling only applies while Gin is active.

There are no third-party PHP library requirements.

## Install with Composer

Install everything together from the project root:

```bash
composer require drupal/gin_type_tray -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Type Tray** module (and the **Gin** theme, if not already present) and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin_type_tray -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependency (Drush enables Type Tray automatically as a
requirement):

```bash
drush en gin_type_tray -y
```

## Set Gin as your admin theme

If you haven't already, make sure Gin is your administration theme at
**Appearance** (`/admin/appearance`), or via Drush:

```bash
drush theme:enable gin -y
drush config:set system.theme admin gin -y
```

There are no submodules and **no configuration step** — enabling the module (with
Type Tray configured and Gin active) is the whole setup. Visit **Content → Add
content** (`/node/add`) to see the Gin-styled tray.
