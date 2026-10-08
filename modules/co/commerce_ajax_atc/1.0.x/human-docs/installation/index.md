# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce 2.8+ or 3** (`drupal/commerce:~2.8 || ^3.0`).
- Commerce's **Cart** module (`commerce_cart`) — the only module dependency, and it
  comes in automatically with Commerce.

Optional integrations you can add later:

- **Colorbox Load** (`drupal/colorbox_load`) — required only if you want the
  Colorbox pop‑up confirmation style.
- **Commerce Variation Cart Form** (`drupal/commerce_variation_cart_form`) — AJAX
  support for its add‑to‑cart form.
- **Commerce VADO** (`drupal/commerce_vado`) — AJAX support for its group
  add‑to‑cart form.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_ajax_atc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_ajax_atc -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_ajax_atc -y
```

## Verify it worked

There is no visible change until you turn AJAX on for a display. Head to
[Configuration](../configuration/index.md), enable the **Enable Ajax** checkbox on a
product type's Manage display, and add a product to your cart from the storefront —
the cart block should refresh without a full page reload.
