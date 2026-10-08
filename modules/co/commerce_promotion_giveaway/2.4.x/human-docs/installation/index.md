# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Commerce** (`commerce`) and **Commerce Promotion** (`commerce_promotion`) from
  the [Drupal Commerce](https://www.drupal.org/project/commerce) suite. Drupal
  enables Commerce Promotion as a dependency.

There are no additional PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_promotion_giveaway -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_promotion_giveaway -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_promotion_giveaway -y
```

## Verify it worked

Go to **Commerce → Promotions → Add promotion** (`/promotion/add`). In the
**Offer** section you should now be able to select **Giveaway** as the offer type.
Continue to [Configuration](../configuration/index.md) to set it up.
