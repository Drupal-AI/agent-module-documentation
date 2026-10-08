# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9||^10||^11||^12`).
- **Drupal Commerce** (`commerce`) with the **Commerce Payment** submodule
  (`commerce_payment`).
- A **Viva Wallet (Viva.com) merchant account** with your smart‑checkout client
  credentials (client ID and client secret) and a merchant/API key.
- HTTPS on your site — required for card payments and for Viva to reach the webhook.

There are no third‑party Composer or PHP library requirements beyond Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_vivawallet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_vivawallet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_vivawallet -y
```

Commerce and Commerce Payment are enabled automatically as dependencies if they
aren't already.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — a
Viva Wallet plugin should be available. Continue to
[Configuration](../configuration/index.md) to set it up.
