# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Users need a TOTP **authenticator app** (Google Authenticator, Authy, or
  similar) to generate their codes.
- No other contrib modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/alogin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alogin -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alogin -y
```

Once enabled, configure enforcement on the settings page and have users enrol
their devices — see [Configuration](../configuration/index.md).
