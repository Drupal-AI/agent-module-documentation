# Installation

## Requirements

Commerce Shipping is a Drupal Commerce add-on, so it needs a working Commerce
store first. Specifically:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce 3.3 or newer** (`drupal/commerce:^3.3.0`), including its
  **Commerce Order** and **Commerce Price** modules.
- The **Physical** module (`drupal/physical:^1.0`), which provides the weight and
  dimension values shipments and package types rely on.

Composer pulls Commerce and Physical in automatically when you require the module.
The Commerce submodules (`commerce_order`, `commerce_price`) are enabled as
dependencies when you turn Commerce Shipping on.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Commerce, Physical,
and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_shipping -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping -y
```

Enabling it also enables the Commerce modules it depends on if they aren't already
on. Once installed, the **Shipping** configuration menu appears under
**Commerce → Configuration**.

There are no submodules to consider — Commerce Shipping is a single module. Carrier
integrations (UPS, USPS, FedEx, etc.) are separate contrib modules you install the
same way when you need real-time rates.

## Next steps

Enabling the module does not, by itself, charge anyone for shipping. You still need
to turn shipping on for an order type and create at least one shipping method — see
[Configuration](../configuration/index.md).
