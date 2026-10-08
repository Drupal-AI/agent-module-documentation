<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules and no third-party PHP libraries are required. Storage
  uses core's State API, so there is no database table to install.

## Install with Composer

From the project root:

```bash
composer require drupal/api_status -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_status -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_status -y
```

## Next steps

Grant the **`access api status dashboard`** permission (**People → Permissions**)
to the roles that should view the report at `/admin/reports/api-status`. Then wire
the tracker service into your integration code so it logs successes and failures —
see the [main guide](../index.md) and the sibling
[`agent/api/service.md`](../agent/api/service.md).
