# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — a hard dependency, enabled automatically
  when you turn this module on. Core's **Field UI** module lets you assign the
  widget on *Manage form display*.

There are no third‑party Composer or PHP library requirements — the ImagerJS
editor ships inside the module.

## Install with Composer

From the project root:

```bash
composer require drupal/imagecroper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagecroper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagecroper -y
```

There are no submodules. Enabling the module makes the **Imager Widget** available
as a widget option for image fields — see
[Configuration](../configuration/index.md) to switch a field over to it.
