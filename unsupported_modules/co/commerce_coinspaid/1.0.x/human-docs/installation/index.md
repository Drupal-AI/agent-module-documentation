# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`.info.yml` declares
  `core_version_requirement: ^8 || ^9 || ^10 || ^11`); in practice use a
  Drupal Commerce-supported release (Drupal 10 or 11).
- **Commerce Payment** (`commerce_payment`) enabled — it ships with Drupal
  Commerce.
- A **CoinsPaid merchant account**, which provides the public and secret keys the
  gateway needs.
- Outbound HTTPS from your server, an HTTPS checkout, and the ability for CoinsPaid
  to reach your callback endpoint.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

The Composer package name differs from the module's machine name — the project is
**`drupal/coinspaid`**. From the project root:

```bash
composer require drupal/coinspaid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/coinspaid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `commerce_coinspaid` (even though the package is
`drupal/coinspaid`):

```bash
drush en commerce_coinspaid -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can add the CoinsPaid
gateway. Then follow [Configuration](../configuration/index.md) to enter your keys
and run a test payment, confirming the order completes only when the signed callback
verifies.
