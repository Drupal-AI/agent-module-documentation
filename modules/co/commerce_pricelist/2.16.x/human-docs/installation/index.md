# Installation

## Requirements

Commerce Pricelist is an add‑on for Drupal Commerce, so you need Commerce in place
first. Specifically:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- **Drupal Commerce 2.25+ or 3** (`drupal/commerce:^2.25 || ^3`).
- Commerce's **Store** (`commerce_store`) and **Price** (`commerce_price`)
  components, plus core's **File** (`file`) module. These come in automatically as
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_pricelist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Commerce components it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_pricelist -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_pricelist -y
```

Enabling it also enables the Commerce Store, Commerce Price and File modules if
they are not already on. Once enabled, a **Price lists** item appears under the
Commerce admin menu.

## Verify it worked

Log in as an administrator and go to **Commerce → Price lists**
(`/admin/commerce/price-lists`). You should see an empty price‑list collection with
an **Add price list** button. From here, continue to
[Configuration](../configuration/index.md) to build your first list.
