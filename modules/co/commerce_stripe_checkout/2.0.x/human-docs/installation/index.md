# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce**, including **Order** (`commerce_order`), **Cart** (`commerce_cart`),
  and **Payment** (`commerce_payment`). These come with Commerce and Drupal enables them as
  dependencies.
- A **Stripe account** with API keys, and the payment methods you want to offer activated in
  your Stripe Dashboard.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_stripe_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_stripe_checkout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_stripe_checkout -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — the Stripe
Checkout plugin should be selectable. Continue to
[Configuration](../configuration/index.md) to enter your keys, choose payment methods, and —
importantly — set the webhook signing secret.
