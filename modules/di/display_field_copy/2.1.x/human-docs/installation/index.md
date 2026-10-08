<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Display Suite** (`drupal/ds: ^3.23`) — this is a hard dependency and provides the
  field UI and rendering framework this module plugs into. Composer pulls it in and
  Drupal enables it as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/display_field_copy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Display Suite) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/display_field_copy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en display_field_copy -y
```

This also enables Display Suite if it was not already on. There are no submodules and
no configuration form.

## After enabling

For copies to be useful, the entity display you want to work on must be managed by
Display Suite. Then go to **Structure → Display Suite → Fields**
(`/admin/structure/ds/fields`) and use **Create a copy of a field** — see
[How to use it](../index.md#how-to-use-it) on the overview page for the full
walkthrough.
