# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce Promotion** (`commerce_promotion`) enabled — this is the module
  dependency. It ships with Drupal Commerce; enable it if you have not already.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_coupon_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_coupon_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_coupon_conditions -y
```

## Verify it worked

Edit a promotion at **Commerce → Promotions**, add a coupon, and open the
**Conditions** section. The extra conditions from this module should appear
alongside Commerce's built‑in ones. See "How to use it" in the
[overview](../index.md) for the AND/OR gotcha worth knowing before you rely on
them.
