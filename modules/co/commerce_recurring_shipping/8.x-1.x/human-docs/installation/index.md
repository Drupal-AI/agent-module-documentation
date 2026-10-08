# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce Recurring** (`commerce_recurring`) — the subscription framework.
- **Commerce Shipping** (`commerce_shipping`) — the shipping framework.

Both are part of the wider [Drupal Commerce](https://www.drupal.org/project/commerce)
ecosystem and must be installed and enabled. There are no additional PHP library
requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_recurring_shipping -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_recurring_shipping -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_recurring_shipping -y
```

## Verify it worked

Enabling the module alone doesn't change anything until you mark a subscription
type as shippable. Go to **Commerce → Subscriptions → Settings** and confirm you
can select which subscription types should be shippable — see
[Configuration](../configuration/index.md).
