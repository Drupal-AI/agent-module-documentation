# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Text** module (`text`) — this is the only dependency, and Drupal
  enables it automatically when you turn on String Field Formatter.

There is no PHP version requirement and there are no third-party Composer
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/string_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/string_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en string_field_formatter -y
```

Once enabled, the **Plain string formatter** option is immediately available on
the *Manage display* page for any `string` or `string_long` field — see
[the index page](../index.md) for how to select and configure it. There is no
configuration form of its own.

There are no submodules.
