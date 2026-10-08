# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Commerce** (`commerce`) and **Commerce Payment** (`commerce_payment`) enabled —
  both ship with Drupal Commerce.
- A **CoinPayments.net merchant account**, which gives you the merchant id, API
  public/private keys, and IPN secret.
- The ability for CoinPayments' servers to reach your site's IPN endpoint, and an
  HTTPS checkout.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_coinpayments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_coinpayments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_coinpayments -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can add the
CoinPayments gateway. Then follow [Configuration](../configuration/index.md) to
enter your credentials, grant the IPN permission so CoinPayments can reach the
callback, and run a sandbox order to confirm the IPN transitions the payment to
completed.

> **Note:** this module is not covered by Drupal's security advisory policy. Keep it
> updated and test on staging.
