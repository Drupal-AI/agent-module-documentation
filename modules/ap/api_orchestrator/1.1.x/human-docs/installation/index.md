<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third-party PHP libraries and no other contrib modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/api_orchestrator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_orchestrator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_orchestrator -y
```

## Next steps

Grant the module's management permission to trusted roles only (**People →
Permissions**), then configure the orchestration services and build your API flows
as described in the [main guide](../index.md). Store any API credentials as
secrets and call endpoints over HTTPS.
