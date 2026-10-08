# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required, and there are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_ignore_pattern -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_ignore_pattern -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_ignore_pattern -y
```

## Configure the patterns

This module has no settings form — add your ignore patterns to `settings.php`. See
the [overview](../index.md#how-to-configure-it-in-settingsphp) for the exact
`$settings['config_ignore_patterns']` syntax and the optional debug flag.

## Verify it worked

1. Add a pattern to `settings.php` and set
   `$settings['config_ignore_pattern_debug'] = TRUE;`.
2. Run `drush config:export` (or open
   `/admin/config/development/configuration`). The debug messages should name the
   config items being ignored, confirming your pattern matches what you intend —
   and only what you intend.
