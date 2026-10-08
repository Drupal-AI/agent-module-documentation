# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, PHP extensions, or third-party libraries are required.

Testmode is a development/testing tool. Install it as a dev dependency in the
environments where you run tests (local and CI), and keep it disabled — ideally
absent — in production.

## Install with Composer

From the project root:

```bash
composer require drupal/testmode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/testmode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en testmode -y
```

## Verify it worked

After enabling, visit the Testmode settings form (route
`testmode.admin_settings`). If it opens, the module is installed. Nothing else
changes on the site until a test tagged `@testmode` activates test mode.
