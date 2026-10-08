# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or newer.**
- **Drupal Commerce 3.x** with its payment, order and checkout modules — the module
  depends on `commerce`, `commerce_payment`, `commerce_order` and
  `commerce_checkout`, which are enabled automatically as dependencies.
- An **EnZona merchant account** and its API credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_enzona
```

Composer resolves Drupal Commerce (`^3.3`) as a dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_enzona`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_enzona -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If **Enzona Redirect Checkout** appears in the plugin
list, the module is installed. Continue to
[Configuration](../configuration/index.md).
