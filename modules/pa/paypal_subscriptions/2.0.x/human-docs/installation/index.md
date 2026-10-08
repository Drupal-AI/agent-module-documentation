# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Drupal Commerce** with the **Commerce Payment** (`commerce_payment`) and
  **Commerce PayPal** (`commerce_paypal`) modules installed and configured. This
  module extends `commerce_paypal`'s Express Checkout gateway, so that integration
  must already be in place.
- A **PayPal business account** enabled for recurring payments (reference
  transactions / recurring payments profiles), plus the NVP/Express Checkout API
  credentials Commerce PayPal uses.

## Install with Composer

Installing with Composer pulls in Commerce and Commerce PayPal as dependencies if
they are not already present:

```bash
composer require drupal/paypal_subscriptions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paypal_subscriptions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paypal_subscriptions -y
```

Drupal will enable `commerce_payment` and `commerce_paypal` automatically as
dependencies if they are not already on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
"PayPal recurring (Express Checkout)" should appear in the list of gateway types.
Continue in [Configuration](../configuration/index.md).
