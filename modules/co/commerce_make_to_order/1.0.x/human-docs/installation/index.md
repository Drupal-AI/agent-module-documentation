# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (always present).
- **Drupal Commerce 2.x or 3.x**, with its **Order** (`commerce_order`),
  **Number Pattern** (`commerce_number_pattern`), and **Log** (`commerce_log`)
  submodules — Commerce enables these as dependencies.
- The **State Machine** module (`state_machine`), which provides the production
  workflow engine.
- *(Optional)* **Commerce Shipping** — enables the shipment-integration
  completion mode, where production orders link to the checkout shipment and the
  Commerce order is promoted to a ready state once all of them complete.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_make_to_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in State Machine and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_make_to_order -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_make_to_order -y
```

## Verify it worked

After enabling, go to **Commerce → Configuration → MTO order types**
(`/admin/commerce/config/mto-order-types`). If you can reach that page, the module
is installed correctly. Nothing happens automatically yet — head to
[Configuration](../configuration/index.md) to create your first MTO order type and
tell the module which Commerce order state should trigger production.
