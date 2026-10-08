# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Drupal Commerce Core** (v2 or v3) — specifically **Commerce Product**
  (`commerce_product`) and **Commerce Order** (`commerce_order`).
- **Commerce Shipping** (`commerce_shipping`).
- An **Amazon Seller Central** account with an **SP‑API app** (Sellers business
  entity) that you can self‑authorize to obtain a refresh token.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_amazon_sp_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and upgrade shared
dependencies (Drupal Commerce and Commerce Shipping). The module has no external
SP‑API SDK — it calls the SP‑API directly over Drupal's HTTP client.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_amazon_sp_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_amazon_sp_api -y
```

## Store your SP-API credentials as secrets

Your **LWA credentials** (client ID and client secret) and **refresh token** are
secrets and must never be committed to version control. With DDEV, you can keep them
out of the repo as environment variables:

```bash
ddev dotenv set .ddev/.env --amazon-lwa-client-id=<value> --amazon-lwa-client-secret=<value> --amazon-refresh-token=<value>
ddev restart
```

Where the Amazon App entity supports referencing a Key, install the Key module
(`ddev composer require drupal/key && ddev drush en key -y`) and back the values
with Key entities using the env provider; otherwise keep them in environment
variables rather than pasting raw secrets into config that could be exported.

## Verify it worked

Continue to [Configuration](../configuration/index.md) to create your Amazon App and
Marketplace, run cron to sync inventory, and enable order integration. Then place a
test order that meets your conditions and confirm a fulfillment record is created on
Amazon and tracked back in Drupal.
