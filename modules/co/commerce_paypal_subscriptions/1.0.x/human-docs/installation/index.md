# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Commerce PayPal** module (`commerce_paypal`) — this is the declared
  dependency; it in turn requires Drupal **Commerce** with the **Payment** module
  (`commerce_payment`). Composer pulls `drupal/commerce_paypal` in for you.
- A **PayPal business account** with API credentials (**client ID** and **client
  secret**). For the modern subscriptions API you'll also have (or auto-generate) a
  PayPal product and subscription plan.

There are no additional third‑party Composer libraries you install separately.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_paypal_subscriptions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_paypal_subscriptions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_paypal_subscriptions -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm that the **Paypal checkout subscriptions** payment method appears. Then
follow [Configuration](../configuration/index.md).
