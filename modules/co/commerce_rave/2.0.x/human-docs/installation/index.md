# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce Payment** (`commerce_payment`) from the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite. Install and
  enable Drupal Commerce and its sub-modules first; Drupal will pull in
  `commerce_payment` as a dependency.
- A **Flutterwave Rave account** with your **public** and **secret** API keys.

There are no additional PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_rave -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_rave -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_rave -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the Rave plugin appears in the list. Then continue to
[Configuration](../configuration/index.md).
