# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module enabled (`commerce`,
  `commerce_payment`). Drupal enables these dependencies for you when you turn on
  this module.
- A **Barion merchant account** with your Barion e‑mail and Secret key (POSKey).
- The **`barion/barion-web-php` `^2.0`** PHP library. Installing the module with
  Composer pulls this in automatically; the module's install check
  (`hook_requirements`) refuses to install if the `Barion\BarionClient` class is
  not found.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_barion_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_barion_payment -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_barion_payment -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**, click
**Add payment gateway**, and confirm **Barion** appears in the plugin list. Then
continue to [Configuration](../configuration/index.md).
