# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Product** module (`commerce_product`)
  enabled.
- The **Paragraphs** module (`paragraphs`).
- Drupal core's **Taxonomy** (`taxonomy`), **Text** (`text`), and **Media**
  (`media`) modules.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_product_csv -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_csv -y
```

## Verify it worked

1. Grant the **Import and export products via CSV** permission
   (`administer product csv`) to a trusted role at **People → Permissions**.
2. Go to **Commerce → Products** and look for the **Import / Export CSV** action
   link, or visit **`/admin/commerce/products/csv`** directly. If you can choose a
   product type and reach its import/export page, the module is installed
   correctly.

See [How to use it](../index.md#how-to-use-it) on the overview page for the full
import and export walkthrough, including the CSV column rules.
