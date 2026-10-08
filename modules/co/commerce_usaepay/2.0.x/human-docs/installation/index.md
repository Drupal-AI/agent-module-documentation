# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** submodule
  (`commerce_payment`) — the only module dependency.
- **PHP SOAP extension** installed and enabled — the gateway talks to USAePay over
  SOAP, so this is required.
- A **USAePay merchant account** with API credentials (source key and PIN).
- HTTPS on your site (required for handling card data).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_usaepay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_usaepay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV's web
> container includes the PHP SOAP extension.

## Confirm PHP SOAP is available

```bash
ddev exec 'php -m | grep -i soap'
```

If `soap` is listed, you're set. On a non‑DDEV host, install/enable the `php-soap`
extension for your PHP version.

## Enable the module

```bash
drush en commerce_usaepay -y
```

Commerce Payment is enabled automatically as a dependency if it isn't already.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — a
USAePay plugin should be available. Continue to
[Configuration](../configuration/index.md) to set it up.
