# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Collector Systems** account and API credentials.

The module declares no other module or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/collector_systems -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/collector_systems -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en collector_systems -y
```

## Verify it worked

Once enabled, enter your Collector Systems API credentials on the module's settings
screen (see "How to use it" on the [overview page](../index.md)). With valid
credentials in place, the module can fetch collection data from the Collector
Systems API for display on your site.
