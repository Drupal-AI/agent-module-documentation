# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`).
- A **Moyasar account** with API and secret keys from the Moyasar dashboard.
- *(For Mada cards)* the patch referenced on the project page may be required.

## Install with Composer

From the project root (Composer is the recommended install method):

```bash
composer require drupal/commerce_moyasar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_moyasar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_moyasar -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Moyasar** plugin should appear in the list. Continue to
[Configuration](../configuration/index.md) to enter your keys.
