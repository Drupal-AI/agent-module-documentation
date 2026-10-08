<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **REST** module (`rest`), which the module depends on and enables
  automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/api_insight_lab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_insight_lab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_insight_lab -y
```

Enabling `api_insight_lab` also enables core's REST module if it is not already on.

## Next steps

Grant the module's permission to the developer roles that should use the testing
suite (**People → Permissions**) — keep it restricted to trusted developers, since
the tool can send arbitrary requests. Then use it as described in the
[main guide](../index.md).
