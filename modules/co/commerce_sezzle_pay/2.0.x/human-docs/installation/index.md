# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Drupal **Commerce** with the **Payment** module (`commerce_payment`) enabled.
- A **Sezzle merchant account** — sign up at
  `https://dashboard.sezzle.com/` to get your public and private API keys (use
  `https://sandbox.dashboard.sezzle.com/` for test keys).

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_sezzle_pay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_sezzle_pay -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_sezzle_pay -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **Sezzle Pay** plugin is offered. Then continue to
[Configuration](../configuration/index.md).

> The Sezzle button is unstyled by default (its element id is
> `#edit-lfi-offsite-payments-offsite-payments-payment-method-sezzle-pay`), so
> you may want to add some CSS in your theme so customers can see it.
