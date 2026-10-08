# Installation

## Requirements

- **Drupal 8.7.7+, 9, 10, or 11** (`core_version_requirement:
  ^8.7.7||^9||^10||^11`).
- **Commerce Shipping Pickup API** (`commerce_shipping_pickup_api`) — the pickup
  framework this module builds on. It is installed automatically as a Composer
  dependency and, in turn, pulls in Drupal Commerce.
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_pickup_pickpackpont -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the pickup API
framework and Commerce as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_shipping_pickup_pickpackpont -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_pickup_pickpackpont -y
```

Enabling it also enables the Commerce Shipping Pickup API framework if it is not
already on.

## Add the checkout pane

1. Go to **Commerce → Configuration → Checkout flows** and edit the flow you use.
2. Add the **Shipping information** pane whose summary reads *Supports pickup*
   (`pickup_capable_shipping_information`) — or switch to the pre‑built pickup
   checkout flow.

## Verify it worked

Go to **Commerce → Configuration → Shipping methods → Add shipping method** and
confirm the Pick Pack Pont pickup plugin appears in the plugin selector. After
adding the method (see [Configuration](../configuration/index.md)), place a test
order and confirm the Pick Pack Pont point selector appears at checkout.
