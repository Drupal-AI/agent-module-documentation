<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **APCu PHP extension** (`krakjoe/apcu`) installed and enabled on the server.
  The module surfaces that extension's diagnostics, so without APCu there is
  nothing for it to report.
- No other Drupal modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/apcu_diagnostics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apcu_diagnostics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apcu_diagnostics -y
```

## Grant the permission

The module provides its own permission to view the diagnostics. Under
**People → Permissions** (`/admin/people/permissions`), grant it only to trusted
administrator roles — the cache internals it exposes reveal operational detail
about your server. Once granted, those users can open the diagnostics and inspect
the live APCu state.
