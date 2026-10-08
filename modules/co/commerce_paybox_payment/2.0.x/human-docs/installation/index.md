# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Commerce's **Payment** module (`commerce_payment`) enabled — the only module
  dependency.
- PHP's **OpenSSL** extension enabled on your server — the module uses
  `openssl_verify()` to check the signature on Paybox's return.
- A **Paybox / Verifone merchant account** (site, rank, identifier) and the **Paybox
  public key** used to verify return signatures. Test credentials are available in
  Paybox's bank documentation (French documentation only).

There are no third‑party Composer libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_paybox_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_paybox_payment -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_paybox_payment -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm that **Paybox** appears in the plugin list. Then follow
[Configuration](../configuration/index.md) to enter your credentials and run a test
transaction against Paybox's test environment.
