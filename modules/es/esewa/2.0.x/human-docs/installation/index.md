# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** `^3.0`, which brings the required Commerce submodules:
  **commerce_order**, **commerce_payment** and **commerce_cart**.
- **PHP 8.1 or higher**, with the `curl` and `json` extensions (required by the
  SDK).
- The **`remotemerge/esewa-php-sdk`** `^4.0` Composer library — installed
  automatically when you require the module.

## Install with Composer

Always install this module via Composer so the eSewa PHP SDK is downloaded and
autoloaded for you. From the project root:

```bash
composer require drupal/esewa -W
```

This downloads the module and automatically pulls in `remotemerge/esewa-php-sdk`
`^4.0` and regenerates the autoloader.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/esewa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en esewa -y
drush cr
```

Or enable **eSewa Payment Gateway** (under the Commerce package) from
**Extend** (`/admin/modules`) and then clear caches.

## Verify the SDK library

Confirm the SDK autoloads correctly:

```bash
php -r "require 'vendor/autoload.php'; echo class_exists('RemoteMerge\\Esewa\\EsewaFactory') ? 'SDK OK' : 'SDK MISSING';"
```

Expected output is `SDK OK`. If you see `SDK MISSING`, run `composer install`
followed by `drush cr`.

## Verify it worked

Once enabled, go to **Commerce → Configuration → Payment gateways** and click
**Add payment gateway** — **eSewa** should appear in the plugin dropdown. Continue
with the [Configuration](../configuration/index.md) steps to finish setting it up.
