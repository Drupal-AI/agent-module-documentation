<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  this module.
- No third-party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_admin_theme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_admin_theme -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_admin_theme -y
```

The admin-theme override is **on by default**, so Layout Builder editing screens
switch to your admin theme right away. To toggle it or change which theme is used,
see [Configuration](../configuration/index.md).

This module has no submodules.
