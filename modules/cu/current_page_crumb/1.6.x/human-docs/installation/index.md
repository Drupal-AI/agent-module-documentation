<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- No contributed-module dependencies and no third-party PHP libraries — it builds
  on core only.
- The core **Breadcrumb** block (`system_breadcrumb_block`) must be placed in your
  active theme, or no breadcrumbs render at all. This is the module's only real
  prerequisite.

## Install with Composer

From the project root:

```bash
composer require drupal/current_page_crumb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/current_page_crumb -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en current_page_crumb -y
```

That's the entire setup — there is no configuration. If breadcrumbs don't show up,
place the core **Breadcrumb** block in your theme at **Structure → Block layout**.

This module has no submodules.
