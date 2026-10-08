# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1||^11`).
- **Commerce** (`commerce`) and **Commerce Payment** (`commerce_payment`) — the
  Drupal Commerce payment framework these gateways plug into. Drupal enables them
  as dependencies.
- A **merchant account** with each Iranian bank whose gateway you intend to use,
  and the credentials (terminal / merchant IDs, keys) that bank issues.

There are no additional third‑party PHP libraries to install. This project **is**
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_irpaymentpack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (Commerce, Commerce Payment) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_irpaymentpack -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_irpaymentpack -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The Iranian bank gateways (Saman, Mellat, Melli, ZarinPal, Zibal, Pasargad,
Saderat) should now appear in the plugin list. Continue in
[Configuration](../configuration/index.md).
