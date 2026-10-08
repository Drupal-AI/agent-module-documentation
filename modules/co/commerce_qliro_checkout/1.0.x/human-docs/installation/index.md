# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Payment** (`commerce_payment`) — part of the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite. Drupal will
  enable it automatically as a dependency, but you need Commerce itself installed
  on the site first.
- A **Qliro merchant account** with API credentials. You will not be able to
  finish configuration without them.

The module also pulls in the **Qliro PHP SDK** (`iqv/qliro_php_sdk`) and the full
**Drupal Commerce** package (`drupal/commerce`) as Composer dependencies. Composer
installs these automatically when you require the module (below), so there is
nothing extra to download by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_qliro_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_qliro_checkout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_qliro_checkout -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
Qliro Checkout should appear in the list of gateway plugins you can choose. From
there, continue to [Configuration](../configuration/index.md) to enter your
credentials.
