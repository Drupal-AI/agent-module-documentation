# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). The `8.x-1.0`
  and later releases are Drupal 10+ only; Drupal 9 sites must stay on
  `8.x-1.0-beta7`.
- **Commerce Payment** (`commerce_payment`), **Commerce Order**
  (`commerce_order`), and **Commerce Log** (`commerce_log`) enabled — these are
  the module dependencies. All ship with Drupal Commerce.
- A **CyberSource account** (live or sandbox) configured for Secure Acceptance
  Hosted Checkout and/or Flex Microform. You can create a developer/sandbox
  account to test against.

> **Note on the client library.** The module uses a Centarro‑maintained fork of
> CyberSource's PHP REST client, because the official client's dependencies
> conflict with Drupal's. Composer resolves this for you when you require the
> module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cybersource -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_cybersource -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cybersource -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** —
CyberSource should be available as a gateway type. Before taking real payments,
follow [Configuration](../configuration/index.md), including the required
CyberSource account settings and the SameSite cookie note for SAHC.
