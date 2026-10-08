# Installation

## Requirements

TagClouds is a small, core‑only module:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Taxonomy** module (`taxonomy`), enabled — it is the only dependency, and it
  provides the terms the clouds are built from.

There are no third‑party Composer packages or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/tagclouds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tagclouds -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tagclouds -y
```

Or enable **TagClouds** from **Extend** (`/admin/modules`).

There are no submodules.

## Next steps

Enabling the module immediately gives you the cloud pages and makes the tag‑cloud blocks
available to place. To tune the clouds, place a block, and learn the page URLs, continue
to [Configuration](../configuration/index.md).
