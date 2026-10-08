# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce** (`commerce`) and **Commerce Promotion** (`commerce_promotion`) from
  the [Drupal Commerce](https://www.drupal.org/project/commerce) suite — the
  referral discounts and kickbacks are issued as Commerce promotions/coupons.

There are no additional PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_referral -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_referral -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_referral -y
```

## Verify it worked

Enabling the module adds its own permissions and referral configuration under
**Commerce**. Review the permissions at **People → Permissions**, then set up your
referral programme following the [Configuration](../configuration/index.md) guide.
