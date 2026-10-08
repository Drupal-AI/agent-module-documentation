<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`) — works on Drupal 9, 10,
  and 11.
- Core's **Field** module (`field`), which Drupal enables automatically as a
  dependency.
- No third-party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/field_delimiter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_delimiter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_delimiter -y
```

That's the entire setup — there is no configuration. The **Field Delimiter**
option now appears in the formatter settings of any multi-value field on the
*Manage display* pages. See the [overview](../index.md) for how to set a delimiter.

This module has no submodules.
