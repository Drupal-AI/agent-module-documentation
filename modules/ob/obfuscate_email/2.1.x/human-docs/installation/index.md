<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal enables automatically as a
  dependency.
- No third-party Composer packages or PHP libraries.
- **JavaScript in the visitor's browser** — the address is reassembled
  client-side, so there is no non-JS fallback.

## Install with Composer

From the project root:

```bash
composer require drupal/obfuscate_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/obfuscate_email -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en obfuscate_email -y
```

Once enabled, any field named `field_email` is obfuscated automatically through
the module's field template. To also scramble addresses in rich-text content, add
the filter to a text format — see [Configuration](../configuration/index.md).

This module has no submodules.
