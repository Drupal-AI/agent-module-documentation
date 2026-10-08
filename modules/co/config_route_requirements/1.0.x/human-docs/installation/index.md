# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No modules outside Drupal core are required, and there are no third‑party PHP
  library requirements.

This release (1.0.x) is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/config_route_requirements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_route_requirements -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_route_requirements -y
```

There is nothing to configure — the module provides the `_config` route
requirement for other modules to use.

## Verify it worked

Add a `_config` requirement to a route in a `*.routing.yml` file (see "How to use
it" on the [overview page](../index.md)), set the referenced configuration value to
false, and run `drush cr`. Requesting that route's path should now return a 404.
Flip the value to true, rebuild again, and the route should respond as normal.
