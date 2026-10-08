# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other contrib modules, PHP libraries or third-party Composer packages are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/services_env_parameter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/services_env_parameter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en services_env_parameter -y
```

## Configure it

There is no settings form. Once the module is enabled, set `DRUPAL_SERVICE_*`
environment variables in your hosting environment and rebuild the container (a cache
clear) so the parameters are applied. See the "How to use it" section of the
[main guide](../index.md) for the naming rules and examples.
