# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- **Drupal Commerce** (`drupal/commerce`, `^2.40 || ^3`) with its **Commerce
  Payment** submodule (`commerce_payment`) enabled — this is the payment framework
  the PayPal gateways plug into. Composer pulls Commerce in as a dependency.
- A **PayPal business account**, and API credentials for the product you plan to
  use (a REST app's Client ID and Secret for Checkout and Fastlane; API
  username/password/signature for Express Checkout; Payflow partner/vendor/user/
  password for the Payflow gateways). You will also want **Sandbox** credentials
  for testing.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_paypal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in Drupal Commerce if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_paypal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it along with Commerce Payment (enabled automatically as a dependency):

```bash
drush en commerce_paypal -y
```

Enabling the module makes the PayPal gateways available to pick when you add a
payment gateway in Commerce. Nothing can take a payment until you configure a
gateway — see [Configuration](../configuration/index.md).

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. In
the plugin list you should see the PayPal options — *PayPal Checkout*, *Fastlane by
PayPal*, and the legacy Express Checkout / Payflow entries. If they appear, the
module is installed correctly. Continue with
[Configuration](../configuration/index.md).
