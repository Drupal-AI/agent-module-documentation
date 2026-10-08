# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3 or newer.**
- **Drupal Commerce ^2.36 or ^3**, with the **Commerce Payment**
  (`commerce_payment`), **Commerce Order** (`commerce_order`), and **Commerce
  Price** (`commerce_price`) modules enabled.
- A **Pesapal account** with a consumer key and consumer secret. (Demo/sandbox API
  credentials are available from Pesapal for testing.)

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_pesapal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_pesapal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_pesapal -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. If
the Pesapal plugin appears among the choices, the module is installed correctly.
Continue to [Configuration](../configuration/index.md).
