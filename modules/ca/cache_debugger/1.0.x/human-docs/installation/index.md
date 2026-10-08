# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no module dependencies.
- Drupal must be able to **write a `services.yml` file** in your site directory, since the
  module creates and removes one when you toggle debugging.

## Install with Composer

This is a development tool, so installing it as a dev dependency is sensible:

```bash
composer require --dev drupal/cache_debugger
```

The ordinary `composer require drupal/cache_debugger -W` also works if you need it in your
main dependency set.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/cache_debugger`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_debugger -y
```

Enabling the module does not switch debugging on by itself — you do that on its
configuration page. See [Configuration](../configuration/index.md).

> **Development only.** Never enable render cache debugging on production: it has a
> significant performance impact and adds debug output to the page markup.

## Verify it worked

Go to **Configuration → Development → Cache Debugger**
(`/admin/config/development/cache-debugger`). If you can reach the page and see the toggle,
the module is installed and ready.
