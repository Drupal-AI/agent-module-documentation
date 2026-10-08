# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** with the **Product** module enabled (`commerce_product`).
  Drupal enables this dependency for you when you turn on the module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_better_product_variation_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_better_product_variation_label -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_better_product_variation_label -y
```

## Verify it worked

Open a product that has variations and check how a variation reads in the cart or
in the admin variation list — for the variation types the module applies to, the
label should now be prefixed with the parent product's label. The `:label` token
for `commerce_product_variation` is also available for use in token patterns.
There is no settings form to configure.
