# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Button Formatter has core-only dependencies — no other contrib modules and no
third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/button_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/button_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en button_formatter -y
```

After enabling, grant the *administer button formatter* permission to the roles
that define your design system, then define your button styles and apply the
formatter as described in [Configuration](../configuration/index.md).
