# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- **Commerce Shipping** (`commerce_shipping`) — the only dependency; it (and
  Drupal Commerce) are installed automatically as Composer dependencies.
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_po_box_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce Shipping
and its dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_shipping_po_box_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_po_box_condition -y
```

## Verify it worked

Go to **Commerce → Configuration → Shipping methods** and edit a shipping method.
Under **Conditions → Customer** you should now see a **Shipping PO Box** option.
See the "How to use it" section of the [overview](../index.md) for how to enable
and (optionally) negate it.
