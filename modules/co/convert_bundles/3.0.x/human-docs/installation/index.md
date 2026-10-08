<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No contributed-module dependencies and no third-party PHP libraries.
- To do anything useful, you need at least one entity type with two or more
  bundles (for example two content types) to convert between.

## Install with Composer

From the project root:

```bash
composer require drupal/convert_bundles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/convert_bundles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en convert_bundles -y
```

On install, the module automatically creates one conversion **action** for every
entity type that has two or more bundles (for example `convert_bundles_on_node`),
which is what makes the conversion available from the content list and from VBO.

After enabling, grant the appropriate permissions and then run a conversion — see
[Configuration](../configuration/index.md).

This module has no submodules.
