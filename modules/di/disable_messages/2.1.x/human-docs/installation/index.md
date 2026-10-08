# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`, `drupal/core: >=8`).
- No other module dependencies and no third‑party Composer packages.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_messages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_messages -y
```

On install, the module turns on filtering (with an empty pattern list, so nothing
is hidden yet), enables HTML‑stripping and case‑insensitive matching by default,
and grants the three "view messages" permissions to every existing role. Add your
patterns on the settings form — see [Configuration](../configuration/index.md).

There are no submodules.
