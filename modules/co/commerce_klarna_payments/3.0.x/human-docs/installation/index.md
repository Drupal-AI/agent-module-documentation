# Installation

## Requirements

- **Drupal 9.4+, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- **PHP 8.0 or newer.**
- **Commerce Payment** (`commerce_payment`) and **Commerce Price**
  (`commerce_price`) — the Drupal Commerce payment framework this gateway plugs
  into. Drupal enables them as dependencies.
- A **Klarna account** and its API credentials for the environment/region you
  intend to use.

> **Note:** This is a beta release (`3.0.0-beta7`) and the project is marked *not
> covered* by Drupal's security advisory policy. Test it thoroughly on staging
> before using it on a production storefront.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_klarna_payments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (Commerce Payment, Commerce Price) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_klarna_payments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_klarna_payments -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The Klarna Payments plugin should appear in the list. Continue in
[Configuration](../configuration/index.md).
