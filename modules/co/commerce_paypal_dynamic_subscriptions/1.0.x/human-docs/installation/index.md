# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Commerce PayPal** (`commerce_paypal`) enabled — this is the module dependency,
  and it provides the OAuth-authenticated PayPal HTTP client / Checkout SDK. Drupal
  Commerce comes in as a dependency of Commerce PayPal.
- A **PayPal business account** with API credentials (client id / secret) and at
  least one **subscription plan** created in the PayPal dashboard.

There are no additional third‑party Composer libraries beyond what Commerce PayPal
pulls in.

> **Note:** this project is listed as **not covered** by Drupal's security advisory
> policy. Review the project's issue queue before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_paypal_dynamic_subscriptions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_paypal_dynamic_subscriptions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_paypal_dynamic_subscriptions -y
```

Enabling it will also enable **Commerce PayPal** if it isn't already on. You can
also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm that the **Dynamic Subscriptions** plugin appears. Then follow
[Configuration](../configuration/index.md).
