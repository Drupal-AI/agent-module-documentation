# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- Drupal **Commerce** and **Commerce Shipping** (`commerce_shipping`) enabled.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_carrier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_carrier -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_carrier -y
```

## Permissions

The module adds a permission for managing carriers. At **People → Permissions**,
grant it to the roles (store administrators, fulfilment staff) who should be able
to create and edit carriers.

## Verify it worked

Go to **Commerce → Configuration → Shipping → Carriers**
(`/admin/commerce/config/shipping_carriers`). You should be able to add a
carrier. Then continue to [Configuration](../configuration/index.md).
