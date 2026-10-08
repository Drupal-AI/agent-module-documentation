<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer**.
- The **Token** module (`drupal/token` `^1.15`) — a Composer dependency that is
  pulled in automatically by the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/field_token_value -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `drupal/token`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_token_value -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_token_value -y
```

Drupal enables the Token module at the same time if it is not already on. Once
enabled, add a **Field Token Value** field to any content type, user, taxonomy
term, or media type from its **Manage fields** page — see the
[overview](../index.md) for how to configure it.

This module has no submodules.
