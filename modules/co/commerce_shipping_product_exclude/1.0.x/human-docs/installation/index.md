# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce** (`commerce`) and **Commerce Shipping** (`commerce_shipping`) —
  both installed automatically as Composer dependencies.
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_product_exclude -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce and
Commerce Shipping as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_shipping_product_exclude -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_product_exclude -y
```

## Verify it worked

Two quick checks confirm both halves of the module are available:

- On a product type's **Manage fields** page (**Commerce → Configuration →
  Product types → Manage fields**), the **Add field** list should now include
  the **Exclude Shipping Method** field type.
- When editing a shipping method (**Commerce → Configuration → Shipping
  methods**), an **Allow to exclude From Shipping** condition should be
  available.

See the "How to use it" section of the [overview](../index.md) for the full
setup sequence.
