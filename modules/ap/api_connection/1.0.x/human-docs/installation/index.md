<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No third-party PHP libraries and no other contrib modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/api_connection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_connection -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_connection -y
```

## Optional submodule

- **`api_connection_example`** — a worked example that demonstrates how to build an
  integration on top of the connection layer. Enable it if you want a reference
  implementation to learn from:

  ```bash
  drush en api_connection_example -y
  ```

## Next step

Configure the connection settings and handle your credentials securely — see
[Configuration](../configuration/index.md).
