# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8.0 || ^9 || ^10 || ^11`).
- No other modules are required — Adequate Passwords has no dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/adequate_passwords -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adequate_passwords -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adequate_passwords -y
```

There are no submodules. Once enabled the policy is active immediately using its
default threshold; adjust it to suit your site — see
[Configuration](../configuration/index.md).
