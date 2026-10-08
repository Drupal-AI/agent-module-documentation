# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- No other contrib module dependencies, and no third-party libraries — speech is
  produced by the visitor's **browser**, so there is nothing to install on the
  server for that.

Because it relies on the browser's Speech Synthesis API, the range and quality of
available voices depends on the visitor's browser and operating system; the module
alerts visitors whose browser does not support the API.

## Install with Composer

From the project root:

```bash
composer require drupal/speakeasy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/speakeasy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en speakeasy -y
```

## Set up permissions

Speakeasy provides two permissions to assign at **People → Permissions**:

| Permission | What it allows |
|------------|----------------|
| **Administer Speakeasy settings** | Manage the global configuration page. |
| **Manage Speakeasy user preferences** | Access the personal preferences form at `/user/speakeasy/preferences` to save a preferred voice and speed. |

## Verify it worked

Log in as an administrator and visit **Configuration → Speakeasy**
(`/admin/config/speakeasy`). If the settings form loads, the module is ready — see
[Configuration](../configuration/index.md) to set defaults and place the block.
