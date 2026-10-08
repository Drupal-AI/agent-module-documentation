# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules are required — the module has no dependencies.
- *Suggested companion:* the **Purge** module (`drupal/purge`) if you want to
  invalidate a long-lived proxy cache whenever content changes.

There are no PHP library or third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/http_cache_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/http_cache_control -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_cache_control -y
```

Once enabled, the module adds its fields to the core Performance form. Nothing
changes about your headers until you set values there — see
[Configuration](../configuration/index.md).
