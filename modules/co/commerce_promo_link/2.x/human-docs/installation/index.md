# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Commerce Promotion** (`commerce_promotion`) — the module applies existing
  Commerce coupon codes, so promotions and their coupons are managed by Commerce as
  usual.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_promo_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_promo_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_promo_link -y
```

## Verify it worked

Create a Commerce promotion with a coupon code (under **Commerce → Promotions**),
then visit `/commerce/promotion/{code}` on your site using that code — for example
`/commerce/promotion/10-TEST`. The coupon should be applied and you should be
redirected (to the front page, or to a `?destination=` path if you added one). Check
that the promotion's usage limits and eligibility rules are still respected.
