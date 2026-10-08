# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 7.4** or newer.
- No other contributed modules — it builds on Drupal core's maintenance mode
  alone.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Development →
Maintenance** (`/admin/config/development/maintenance`). You should see the
extended maintenance settings — message options, scheduling, access rules,
redirection, reload behaviour, status code, and themes. See
[Configuration](../configuration/index.md) to set them up.

> **Note:** This module is in a beta release. Test your maintenance configuration
> on a staging environment before relying on it in production.
