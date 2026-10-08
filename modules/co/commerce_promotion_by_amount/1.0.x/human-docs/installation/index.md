# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce 2.29+ or 3.x** (`drupal/commerce: ^2.29 || ^3`), pulled in by
  Composer automatically.
- The **Commerce Promotion** submodule (`commerce_promotion`) enabled — this is a
  hard dependency, and Drupal enables it for you when you turn on this module.

There are no additional PHP libraries or third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_promotion_by_amount -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Commerce) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_promotion_by_amount -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_promotion_by_amount -y
```

Enabling it also enables Commerce Promotion if it was not already on. That is all
the setup there is — the two new offers now appear in the promotion form's **Offer**
selector, ready to use. There are no submodules.

## Verify it worked

Go to **Commerce → Promotions → Add promotion** and open the **Offer** dropdown.
You should see the two new options: **Fixed amount off for cheapest or most
expensive matching product** and **Percentage off for cheapest or most expensive
matching product**. If they are there, you are ready to build a promotion — see
[Configuration](../configuration/index.md).
