# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce** (`commerce`) and **Commerce Payment** (`commerce_payment`) enabled —
  both ship with Drupal Commerce.
- A **Coinbase Commerce merchant account** and an API key. Your site should serve
  **HTTPS**, because the webhook carries a secret validation value.

This 2.0.x release needs **no separate Coinbase PHP library, no special cURL
setup, and no cron** — the module talks to the Coinbase Commerce API using Drupal
core's HTTP client. (You may see older instructions about a "coinbase-php" library
or cron polling; those apply only to the legacy Drupal 7 version.)

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_coinbase
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_coinbase`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_coinbase -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can add the **Coinbase
(Off-site)** gateway. Then follow [Configuration](../configuration/index.md) to
enter your API key and webhook secret, wire the webhook in your Coinbase Commerce
account, and confirm a test payment completes the order once Coinbase sends the
confirmation webhook.

> **Note:** this module is minimally maintained. Confirm current Coinbase Commerce
> API availability before depending on it in production.
