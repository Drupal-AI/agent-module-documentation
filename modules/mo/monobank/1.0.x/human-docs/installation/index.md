# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **AlternativeCommerce (Basket)** module — Monobank is a payment method for
  Basket's ordering system, so you need Basket installed and a store set up.
- A **Monobank acquiring account** and its API token — you enter the token during
  configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/monobank -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monobank -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monobank -y
```

## Verify it worked

Log in as an administrator and open **`/admin/basket/settings-payment`**. You
should be able to create a payment point and choose **Monobank** as its service.
Once created, follow the button through to the gateway settings (or go straight
to **`/admin/config/development/monobank`**). Continue with
[Configuration](../configuration/index.md).
