# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Drupal **Commerce** with **Commerce Shipping** (`commerce_shipping`) enabled.
- **Commerce Shipping Label** (`commerce_shipping_label`) — required, for label
  generation.
- Core's **File** module (`file`) — for storing generated label files.
- A **Colissimo (La Poste) account** with API credentials (login and password).

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_colissimo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce Shipping
Label and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_colissimo -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_colissimo -y
```

Drupal will enable `commerce_shipping_label` and `file` as dependencies if they
are not already on.

## Verify it worked

Go to **Commerce → Configuration → Shipping → Colissimo Settings**
(`/admin/commerce/config/colissimo`). The settings form should load. Then
continue to [Configuration](../configuration/index.md).
