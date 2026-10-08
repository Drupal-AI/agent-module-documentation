# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.3** or newer (`php: ^8.3`).
- Core **Path alias** (`path_alias`), enabled automatically as a dependency.
- **An active Cookie Information account** with a configured consent template on
  their platform (go.cookieinformation.com). The module is only the Drupal-side
  integration — without a subscription and template there is nothing for it to load.

There are no third-party Composer libraries to install; the module injects fixed
vendor script URLs.

## Install with Composer

From the project root:

```bash
composer require drupal/cookieinformation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookieinformation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookieinformation -y
```

## After enabling

The popup does not appear until you turn it on and configure the module. Head to
[Configuration](../configuration/index.md) to enable the consent popup and set the
Google Consent Mode, IAB, and iframe-blocking options.
