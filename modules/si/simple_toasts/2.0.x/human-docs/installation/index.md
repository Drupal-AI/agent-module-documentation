# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9.0||^10||^11`).
- No other modules, PHP extensions or JavaScript libraries are required — Simple
  Toasts is self-contained.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_toasts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_toasts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_toasts -y
```

> **Upgrading from 1.1.x?** There is no upgrade path from 1.1.x to 2.0.x. Uninstall
> the previous version before updating to this release.

After enabling, open [Configuration](../configuration/index.md) to choose which
themes should use toasts — that is the one step that makes the messages appear as
toasts.
