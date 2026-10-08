# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — the only hard dependency, enabled
  automatically as a dependency.
- Optional: core's **Responsive Image** (`responsive_image`) module, if you want
  the **Responsive image delta** formatter, and core's **Media** (`media`) module,
  if you want the **Media delta** formatter. These two formatters simply appear
  once their respective core module is enabled.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/image_delta_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_delta_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_delta_formatter -y
```

There is no configuration page and no required setup. Once enabled, the **Image
delta** formatter (and, where their core modules are on, **Responsive image
delta** and **Media delta**) become available in the **Format** drop‑down on any
bundle's *Manage display* page for multi‑value image and media fields. See the
[overview](../index.md#how-to-use-it) for how to pick a delta.
