# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** with its **Price** and **Store** modules — the module depends
  on `commerce`, `commerce_price` and `commerce_store`. If you don't already run
  Commerce, installing this module with Composer pulls it in.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_giftcard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Drupal Commerce and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_giftcard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_giftcard -y
```

This enables the required Commerce modules too if they are not already on.

## Next steps

Create at least one gift-card type, then issue or generate cards and add the
redemption pane to your checkout flow — all covered in
[Configuration](../configuration/index.md). Grant the gift-card permissions to the
appropriate roles.
