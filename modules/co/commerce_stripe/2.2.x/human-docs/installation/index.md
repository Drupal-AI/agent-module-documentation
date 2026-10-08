<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**, with the **cURL** extension (`ext-curl`).
- **Drupal Commerce 3** (`drupal/commerce` `^3`) and its **Payment** submodule
  (`commerce_payment`).
- The **Stripe PHP library** (`stripe/stripe-php` `^15`) — this is a Composer
  dependency and is installed automatically by the command below.
- A **Stripe account** (create one at stripe.com) so you have publishable and
  secret API keys.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_stripe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the `stripe/stripe-php` library. Installing
Commerce Stripe with Composer (rather than downloading it) is required, because the
Stripe library must be present in `vendor/`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_stripe -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_stripe -y
```

Drupal enables Commerce's Payment module at the same time if it is not already on.

## Submodule — webhook events

Commerce Stripe ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Commerce Stripe Webhook Event** | `commerce_stripe_webhook_event` | Logs and processes incoming Stripe webhook events, so you can inspect what Stripe sent and react to it. |

Enable it if you want webhook logging/processing:

```bash
drush en commerce_stripe_webhook_event -y
```

Next, configure a gateway, store your API keys securely, and set up the webhook —
see [Configuration](../configuration/index.md).
