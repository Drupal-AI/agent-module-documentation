# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Commerce Payment** (`commerce_payment`) — part of Drupal Commerce.
- The **Stripe PHP library**, included via Composer.
- A **Stripe account** with Sofort enabled, and your Stripe API keys.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_stripe_sofort -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed — including the Stripe PHP library this module requires.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_stripe_sofort -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_stripe_sofort -y
```

## Local testing note

Sofort confirmation arrives via a Stripe webhook, so testing on a local machine requires your
site to be reachable from the internet. Expose it with a tunnel such as
[ngrok](https://ngrok.com/) or [Expose](https://beyondco.de/docs/expose/introduction), and
consider the [ngrok_drupal](https://www.drupal.org/project/ngrok_drupal) module so sessions
(login, carts) work over the tunnel.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — **Stripe
Sofort** should appear as a plugin option. Continue to
[Configuration](../configuration/index.md) to configure the gateway and the Stripe webhook.
