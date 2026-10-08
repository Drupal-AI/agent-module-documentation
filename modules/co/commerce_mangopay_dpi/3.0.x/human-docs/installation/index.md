# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`).
- The **mangopay2-php-sdk** PHP library (version ≥ 2.3), pulled in by Composer.
- The **cardregistration-js-kit** JavaScript library (version ≥ 1.2), which you
  download and install manually into your libraries directory.
- A **MANGOPAY account** with API credentials (a client id / API key), available
  in sandbox and production.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_mangopay_dpi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the
mangopay2-php-sdk and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_mangopay_dpi -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Add the MANGOPAY JavaScript kit

The gateway tokenizes cards in the browser using MANGOPAY's card-registration kit,
which is **not** installed by Composer. Download it from
[Mangopay/cardregistration-js-kit](https://github.com/Mangopay/cardregistration-js-kit)
and place it in your libraries directory so the path is:

```
libraries/cardregistration-js-kit
```

Without this library the on-site card form cannot tokenize card data.

## Enable the module

```bash
drush en commerce_mangopay_dpi -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Mangopay** plugin should appear in the list. Then continue to
[Configuration](../configuration/index.md) to enter your credentials.
