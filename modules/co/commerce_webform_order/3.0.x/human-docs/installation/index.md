# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- **Drupal Commerce** (`drupal/commerce`, `^2.19 || ^3.0`) with its Cart,
  Checkout, Order, Price, and Store modules enabled.
- **Commerce Purchasable Entity** (`drupal/commerce_purchasable_entity`, `^1.0`).
- **Webform** (`drupal/webform`, `^6.1`).
- Optional: **Commerce Payment** — required for the Payment Method / Payment
  Status elements and the replacement Payment process checkout pane.
- Suggested: **Token** and **Token OR** — for the token UI and "or‑able" tokens
  used in value mapping.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_webform_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce, Webform,
and their dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_webform_order -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_webform_order -y
```

This enables the required Commerce submodules and Webform if they aren't already
on. There are no submodules of its own. If you plan to collect the payment gateway
on the form, also enable Commerce Payment:

```bash
drush en commerce_payment -y
```

## Next step

The module adds no menu item. Go to a webform's **Handlers** tab
(**Structure → Webforms → {form} → Settings → Handlers**) and add the **Commerce
Webform Order** handler — see [Configuration](../configuration/index.md).
