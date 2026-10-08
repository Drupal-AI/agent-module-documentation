# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **`owenbush/static-settings`** PHP library (`^2.1`) — a Composer library
  dependency (not a Drupal module) that provides the underlying static-settings
  API. Composer pulls it in automatically.

There are no Drupal module dependencies, no permissions, and no admin UI.

## Install with Composer

From the project root:

```bash
composer require drupal/static_setting_contexts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`owenbush/static-settings` library and update any other shared dependencies
together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/static_setting_contexts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en static_setting_contexts -y
```

There are no submodules and nothing to configure in the UI. The module does
nothing visible until you define at least one static setting in code — see [How to
use it](../index.md#how-to-use-it) in the overview, and don't forget the PSR-4
autoloader step, which is required for your settings to be discovered.

## Verify it worked

After defining a static setting (and running `composer dump-autoload`), edit a
block and open its **Visibility** settings. The **Static Settings** condition
should appear with a checkbox group for your setting's values.
