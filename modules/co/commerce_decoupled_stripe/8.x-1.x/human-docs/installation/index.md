# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Commerce Payment** (`commerce_payment`) enabled — this is the module
  dependency. It ships with Drupal Commerce.
- **Commerce Decoupled Checkout** — this module is meant to be used with it, since
  the front end drives the flow through those API endpoints.
- A **Stripe account** with your publishable and secret API keys (Stripe provides
  test keys for integration).

There are no additional third‑party Composer or PHP library requirements declared
by the module. (Client‑side, your front end uses the Stripe.js v3 API.)

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_decoupled_stripe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_decoupled_stripe -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_decoupled_stripe -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** —
**Decoupled Stripe** and **Decoupled Stripe Recurring** should be available as
gateway types. Then follow [Configuration](../configuration/index.md) to enter
your Stripe keys.
