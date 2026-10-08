<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Token** module (`drupal/token` `^1.1`) — this is a Composer dependency
  and is pulled in automatically by the command below.
- Core's **Filter** and **Text** modules, which Drupal enables automatically as
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/token_custom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `drupal/token`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/token_custom -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en token_custom -y
```

Drupal enables the Token, Filter, and Text modules at the same time if they are
not already on. Once enabled, you can create tokens straight away at
**Structure → Custom Tokens** — see [Configuration](../configuration/index.md).

This module has no submodules.
