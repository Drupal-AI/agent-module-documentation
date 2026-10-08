# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/error_reporting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/error_reporting -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en error_reporting -y
```

That's all — there is no configuration step. The improved error display takes effect
immediately.

## Verify it worked

In a development environment, trigger an error and confirm that the output appears
in the module's cleaner, more detailed format. As noted in the
[overview](../index.md), keep this behaviour out of public view on production by
leaving Drupal's core error-display setting configured to hide messages from
visitors.
