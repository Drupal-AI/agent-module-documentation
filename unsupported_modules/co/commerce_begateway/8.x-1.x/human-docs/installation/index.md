# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Drupal Commerce** with **Commerce Payment** (and **Commerce Order**)
  enabled.
- The **Token** module (`token`).
- The **BeGateway API PHP library** (`begateway/begateway-api-php`). Installing
  the module with Composer pulls this in automatically.
- A **BeGateway merchant account** with your shop id, shop key, and secret.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_begateway -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the BeGateway PHP library) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_begateway -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_begateway -y
```

This also enables the Commerce Payment and Token dependencies.

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**, click
**Add payment gateway**, and confirm **BeGateway** appears in the plugin list.
Then continue to [Configuration](../configuration/index.md).
