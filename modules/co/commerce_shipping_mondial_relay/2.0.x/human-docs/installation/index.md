# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Drupal **Commerce** and **Commerce Shipping** (`commerce_shipping`) enabled,
  with the **Shipping information** pane present in your checkout flow (the
  Mondial Relay pane depends on it).
- A **Mondial Relay account** and its widget settings — chiefly your **Brand
  ("Enseigne") code** — from Mondial Relay's documentation.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_mondial_relay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_mondial_relay -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_mondial_relay -y
```

## Verify it worked

Go to **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`), click **Add shipping method**, and confirm
the **Mondial Relay** plugin appears. Then continue to
[Configuration](../configuration/index.md).
