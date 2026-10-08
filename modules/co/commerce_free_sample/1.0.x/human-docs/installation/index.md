# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Order** (`commerce_order`) and **Product**
  (`commerce_product`) modules enabled.
- **Commerce Checkout Order Fields** (`commerce_checkout_order_fields`) — the
  module builds on this to place the sample widget on the checkout form.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_free_sample -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_free_sample -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_free_sample -y
```

On enable, the module automatically wires its `field_free_sample` widget into the
default Commerce order checkout form display, so the picker is ready to appear
once you have configured a sample pool. On uninstall it cleans up its own field
configuration, leaving no orphaned config behind.

## Verify it worked

Go to **Commerce → Free Samples** (`/admin/commerce/free-samples`) — you should
see the settings form where you add sample products. Nothing appears at checkout
yet, because you have not chosen any samples; head to
[Configuration](../configuration/index.md) next.
