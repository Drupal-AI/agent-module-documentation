# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Commerce Payment** (`commerce_payment`) enabled — this is the module
  dependency. It ships with Drupal Commerce.
- A **Datatrans contract / account** with a merchant ID, the API password, and the
  `sign2` HMAC key used to verify webhooks. Datatrans provides test credentials for
  integration testing.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_datatrans -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_datatrans -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_datatrans -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** —
Datatrans should be available as a gateway type. Then follow
[Configuration](../configuration/index.md) to enter your merchant ID, API password,
and `sign2` webhook key. Make sure a payment method exists in Commerce before
testing checkout.
