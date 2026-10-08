# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Payment** (`commerce_payment`) — the Drupal Commerce payment
  framework this gateway plugs into (which brings in Commerce core). Drupal
  enables it as a dependency.
- A **KNET merchant account** with your **terminal ID** and **terminal resource
  key** (used to decrypt and verify the response).

This project **is** covered by Drupal's security advisory policy. Note it is in
*maintenance fixes only* status.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_knet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (Commerce, Commerce Payment) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_knet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_knet -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The KNET plugin should appear in the list. Continue in
[Configuration](../configuration/index.md).
