# Installation

## Requirements

- **Drupal 8.8+, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- **PHP 7.1 or newer**.
- **Commerce Payment** (`commerce_payment`) — part of Drupal Commerce.
- The **`stripe/stripe-php`** library, pulled in automatically by Composer.
- A **Stripe account** with Alipay enabled, and your Stripe API keys.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_stripe_alipay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed — including the `stripe/stripe-php` library this module requires.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_stripe_alipay -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_stripe_alipay -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. **Stripe
Alipay** should appear in the list of gateway plugins. Continue to
[Configuration](../configuration/index.md) to enter your Stripe keys.
