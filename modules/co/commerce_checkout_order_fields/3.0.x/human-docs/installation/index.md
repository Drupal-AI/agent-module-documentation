# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce**, version **3 or newer** (`drupal/commerce: ^3`).
- **Commerce Checkout** (`commerce_checkout`) — part of the Commerce package,
  enabled as a dependency.
- Core's **Field UI** module (`field_ui`) — you need it to add fields and manage
  form displays through the admin UI.

There are no extra third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_checkout_order_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Commerce and any
shared dependencies as needed. (You will already have Commerce installed on a store
site; this simply ensures compatible versions.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_checkout_order_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_checkout_order_fields -y
```

Make sure **Field UI** is on too (it usually is on a Commerce site):

```bash
drush en field_ui -y
```

## Next steps

Enabling the module adds a **Checkout** form-display mode for orders and a checkout
pane, but nothing appears at checkout until you wire them up. Follow the four-step
setup in [Configuration](../configuration/index.md).
