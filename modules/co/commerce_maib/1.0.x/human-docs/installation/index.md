# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`),
  which Commerce provides.
- The **`maib/maibapi`** PHP library, which Composer pulls in automatically when
  you require the module.
- A **MAIB merchant account** with the certificate/PFX file and password the bank
  issues to you.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_maib -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies and pull in the `maib/maibapi` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_maib -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_maib -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
**MAIB** should appear in the list of gateway plugins. From here, continue to
[Configuration](../configuration/index.md) to enter your credentials and load the
bank certificate.
