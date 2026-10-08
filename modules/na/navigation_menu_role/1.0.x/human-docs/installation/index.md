<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **Navigation** (`navigation`), **Block** (`block`), and **System**
  (`system`) modules. Navigation is the experimental left-sidebar navigation feature
  in Drupal 11; these are enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

> **Note:** this module is experimental (its block plugin is declared `final` for now),
> matching the experimental status of core's Navigation feature.

## Install with Composer

From the project root:

```bash
composer require drupal/navigation_menu_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/navigation_menu_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navigation_menu_role -y
```

This also enables the required core modules if they were not already on. There are no
submodules and no configuration form.

## After enabling

The role-aware menu blocks become available in the Navigation editing UI, one per menu
on your site. There is nothing to switch on globally — place a block and set its roles
to start restricting a Navigation menu by role. See
[Configuration](../configuration/index.md) for the details.
