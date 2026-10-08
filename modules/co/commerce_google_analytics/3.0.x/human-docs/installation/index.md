# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Order** module (`commerce_order`) enabled.
- The **GA Push** module (`ga_push`) — this is what actually dispatches events to
  Google Analytics. It is recommended to configure GA Push to work with the
  **PHP-GA** library (or UTMP-PHP) for reliable server-side sending.
- The **Google Analytics** module for your site's base GA tracking.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_google_analytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_google_analytics -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_google_analytics -y
```

## Verify it worked

Configure **GA Push** at **Configuration → System → GA Push**
(`/admin/config/system/ga-push`) with your Google Analytics account, then place a
test order and confirm the transaction appears in your GA e-commerce reports. See
the [main guide](../index.md#how-to-use-it) for how the Rules reaction controls
when data is sent.
