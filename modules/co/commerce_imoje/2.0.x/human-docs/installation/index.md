# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** (Commerce 2) with the **Payment** module
  (`commerce_payment`) enabled — this is the only dependency, and there are no
  additional PHP libraries.
- An **imoje merchant account** (ING) with API credentials and a merchant/service
  ID, plus access to the imoje panel to set the notification address.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_imoje -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_imoje -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_imoje -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway** (or use
`/admin/commerce/config/payment-gateways/add`), and confirm the **imoje** and
**imoje Blik** plugins appear. Then follow
[Configuration](../configuration/index.md) to enter your credentials and set the
notification address in the imoje panel.
