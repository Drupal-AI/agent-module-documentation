<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9.2, 10, 11, or 12** (`core_version_requirement: ^9.2 || ^10 || ^11 || ^12`).
- No contributed-module dependencies and no third-party PHP libraries — it builds
  entirely on core's configuration and typed-data systems.

This is a development/audit tool. It is safe on production but is usually only
enabled on development and CI environments.

## Install with Composer

From the project root:

```bash
composer require drupal/config_inspector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_inspector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_inspector -y
```

Enabling the module is the entire setup — there is nothing to configure. Grant
the **Inspect configuration** permission to your developer role, then visit
**Reports → Configuration inspector**, or run `drush config:inspect`.

This module has no submodules.
