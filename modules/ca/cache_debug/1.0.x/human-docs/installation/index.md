# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No hard third‑party Composer or PHP library requirements, and no module dependencies.
- Optional: the **Raven** module if you want to send cache tags to **Sentry**.
- A working **private file system** if you use the File logger (its default path is
  `private://cache_debug`).

## Install with Composer

This is a development tool, so installing it as a dev dependency is sensible:

```bash
composer require --dev drupal/cache_debug
```

The ordinary `composer require drupal/cache_debug -W` also works if you need it in your
main dependency set.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/cache_debug`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_debug -y
```

Enabling the module does not start logging anything — you must pick your loggers on the
settings form first. See [Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Development → Cache Debug**
(`/admin/config/development/cache-debug`). If you can reach the form and choose loggers,
the module is installed. After selecting a response logger and browsing a page, check your
chosen sink (the file under `private://cache_debug`, the Drupal log, or Sentry) for the
recorded cache tags.
