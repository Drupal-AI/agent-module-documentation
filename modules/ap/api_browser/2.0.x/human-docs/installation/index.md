<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2 || ^12`).
- The core **Project Browser** module (`project_browser`), which this module
  extends. Composer installs it automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/api_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Project Browser
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_browser -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_browser -y
```

Enabling `api_browser` also enables Project Browser if it is not already on.

## Next steps

After enabling, grant the **`administer api_browser_service`** permission to the
roles that should manage API-backed sources (**People → Permissions**), then
configure your external API endpoint(s) and credentials as described in the
[main guide](../index.md). Store credentials securely — prefer environment
variables over exported configuration.
