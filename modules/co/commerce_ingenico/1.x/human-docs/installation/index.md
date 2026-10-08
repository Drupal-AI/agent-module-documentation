# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the core Commerce modules — the module depends on
  **Commerce** (`commerce`) and **Commerce Price** (`commerce_price`), and in
  practice you will run the usual Payment, Checkout, Cart and Order modules of a
  Commerce store.
- Two **third-party PHP libraries**, installed automatically by Composer:
  - `marlon-be/marlon-ogone` — the Ogone/Ingenico API client.
  - `mobiledetect/mobiledetectlib` — device detection used by the gateway.
- An **Ingenico (Ogone) account** with a PSPID, a dedicated API user, and the SHA
  passphrases configured in the back office.

## Install with Composer

Install via Composer so the two libraries above are pulled in for you:

```bash
composer require drupal/commerce_ingenico -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Installing via Composer (rather than downloading the
module by hand) is important here, because the module will not work without
`marlon-be/marlon-ogone` and `mobiledetect/mobiledetectlib` present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_ingenico -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_ingenico -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm that both the **Ingenico DirectLink** and **Ingenico e-Commerce** plugins
appear. Then follow [Configuration](../configuration/index.md) — note you will need
to set up the Ingenico back office first so the SHA passphrases and feedback URLs
match.
