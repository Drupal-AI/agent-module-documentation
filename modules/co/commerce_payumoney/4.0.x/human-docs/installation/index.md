# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Drupal Commerce** (`commerce`) with the **Commerce Payment** module
  (`commerce_payment`) enabled.
- A **PayUMoney merchant account**, which provides your merchant key and salt.
- A customer profile type (default: `customer`) that has an **Address** entity and
  a phone field with the machine name **`field_phone`** — the gateway reads these
  to build the PayU request. You will add the phone field during configuration if
  it is not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_payumoney -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_payumoney -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_payumoney -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. If
**PayUmoney Redirect** appears among the plugins, the module is installed
correctly. Continue to [Configuration](../configuration/index.md).
