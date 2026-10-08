# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Payment** (`commerce_payment`) — the Drupal Commerce payment
  framework this gateway plugs into (which brings in Commerce core). Drupal
  enables it as a dependency. (Drupal Commerce 2.x is required.)
- A **merchant account at Konnect.network** with your **API key**, **API secret**,
  and **receiver wallet ID**.

> **Note:** This is a young project (created January 2026) and is marked *not
> covered* by Drupal's security advisory policy. Test it thoroughly on staging
> before using it on a production storefront.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_konnect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (Commerce, Commerce Payment) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_konnect -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_konnect -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The Konnect plugin should appear in the list. Continue in
[Configuration](../configuration/index.md).
