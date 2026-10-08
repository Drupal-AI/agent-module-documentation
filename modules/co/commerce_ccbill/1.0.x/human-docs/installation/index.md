# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- **Commerce** (`commerce`) and **Commerce Payment** (`commerce_payment`) enabled —
  both ship with Drupal Commerce.
- A **CCBill merchant account** with a FlexForm set up, which gives you the client
  account/subaccount numbers, FlexForm ID, and salt.
- Outbound HTTPS from your server, an HTTPS checkout, and the ability for CCBill's
  servers to reach your post‑back URL.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_ccbill -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_ccbill -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_ccbill -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways/add`) and confirm you can add a gateway
of type **CCBill**. Then follow [Configuration](../configuration/index.md) to enter
your credentials, configure the CCBill background post‑back URL to point at your
notify endpoint, and run a test transaction in CCBill's sandbox before going live.

> **Note:** this module is not covered by Drupal's security advisory policy. Keep it
> updated and test on staging.
