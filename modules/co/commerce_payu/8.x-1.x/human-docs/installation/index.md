# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** module (`commerce_payment`)
  enabled — the only module dependency.
- A **PayU merchant account**, which provides your POS ID, signature key, and
  OAuth client id/secret.

The OpenPayU PHP SDK the module builds on is resolved by Composer when you require
the module, so there is nothing extra to install by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_payu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_payu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_payu -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. If
the **PayU** plugin appears among the choices, the module is installed correctly.
Continue to [Configuration](../configuration/index.md).
