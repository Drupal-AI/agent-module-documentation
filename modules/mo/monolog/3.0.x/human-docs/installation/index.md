# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1.0`).
- The **`monolog/monolog` library, version ^3.2** — this is a Composer dependency,
  so installing with Composer (below) pulls it in automatically. Do not try to
  enable the module without it.

Monolog has no dependencies on other Drupal modules.

## Install with Composer

From the project root:

```bash
composer require drupal/monolog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it is what brings in the `monolog/monolog` PHP library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/monolog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monolog -y
```

The moment it is enabled, Monolog takes over Drupal's logging. With no further
configuration it sends the `default` channel to **syslog** and the `php` channel to
the **web server error log**. To route logs anywhere else, create and register a
services YAML file as described in [How to use it](../index.md#how-to-use-it), then
run `drush cr`.

There are no submodules.
