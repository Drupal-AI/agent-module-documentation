# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Payment** (`commerce_payment`) — the Drupal Commerce payment
  framework this gateway plugs into (which brings in Commerce core). Drupal
  enables it as a dependency.
- A **Klarna account** (or developer access to the account you will configure),
  and the API credentials for the region and environment you intend to use. You
  can sign up on Klarna's site.
- No other third‑party dependencies.

This project **is** covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_klarna -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (Commerce, Commerce Payment) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_klarna -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_klarna -y
```

## Shipping and express checkout

If you plan to use **express checkout on the cart page** and want to **collect the
shipping address through Klarna**, the project also ships a shipping submodule,
**`commerce_klarna_shipping`**. Enable it when you turn on those options in the
gateway configuration — without it, that checkout path will fail:

```bash
drush en commerce_klarna_shipping -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The Klarna plugin should appear in the list. Continue in
[Configuration](../configuration/index.md).
