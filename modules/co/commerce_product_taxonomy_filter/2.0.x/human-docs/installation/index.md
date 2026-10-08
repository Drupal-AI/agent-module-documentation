# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **PHP 8.1 or newer**.
- **Commerce** (`drupal/commerce` `^3`) — the module extends the
  `commerce_product` entity, so a working Commerce install is required. Composer
  pulls it in.
- Core's **Taxonomy** and **Views** are used as well (part of a standard Commerce
  site).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_taxonomy_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce (if not
already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_product_taxonomy_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_taxonomy_filter -y
```

On enable, the module creates its product↔term index table and **backfills it from
your existing products**, so the new Views handlers work against your current
catalog right away. (Uninstalling drops that table.)

## Verify it worked

Make sure at least one of your product types has an **entity reference field that
targets taxonomy terms** (a Category, Brand, or Tags field) — that's what the index
reads. Then edit a View of *Products*: under filters, arguments, and relationships
you should now see the new **taxonomy term** options. There's nothing else to
configure; head back to the [overview](../index.md#how-to-use-it) for how to use
them.
