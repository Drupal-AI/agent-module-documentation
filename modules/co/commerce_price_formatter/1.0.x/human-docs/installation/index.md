# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Product** (`commerce_product`) and
  **Commerce Promotion** (`commerce_promotion`) modules enabled — the formatting
  only makes sense where you have products and promotions.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_price_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_price_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_price_formatter -y
```

## Verify it worked

There is no settings page to check. Instead, go to **Commerce → Configuration →
Product variation types → (a type) → Manage display**, set the **price** field to
**Calculated (Format)**, and confirm that a **Enable Discount Format to Calculated
Price** option now appears in that formatter's settings. See
[How to use it](../index.md#how-to-use-it) on the overview page for the full
walkthrough.
