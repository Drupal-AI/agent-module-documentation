# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- **Commerce Payment** (`commerce_payment`) — part of Drupal Commerce.
- The **`stripe/stripe-php`** library, pulled in automatically by Composer.
- A **Stripe account** with Klarna enabled, in a supported country/currency (see
  Configuration), and your Stripe API keys.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_stripe_klarna -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed — including the `stripe/stripe-php` library this module requires.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_stripe_klarna -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_stripe_klarna -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Because the module ships a default gateway
config, a **Commerce Klarna Stripe** gateway may already appear in the list; otherwise click
**Add payment gateway** and choose the Stripe Klarna plugin. Continue to
[Configuration](../configuration/index.md) to enter your Stripe keys.
