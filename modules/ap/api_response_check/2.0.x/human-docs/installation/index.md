<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other contrib modules and no third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/api_response_check -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_response_check -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_response_check -y
```

## Next step

Enter the URLs you want to monitor and review the results — see
[Configuration](../configuration/index.md).
