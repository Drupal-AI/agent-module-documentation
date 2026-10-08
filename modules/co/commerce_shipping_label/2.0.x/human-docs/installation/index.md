# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Drupal **Commerce** and **Commerce Shipping** (`commerce_shipping`) enabled.
- A carrier / shipping-service module that integrates with this label API (for
  example **Commerce EasyPost** or **Commerce Shipping Colissimo**) if you want
  real carrier labels — on its own this module only provides the API.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_label -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_label -y
```

## Submodules

- **Commerce Shipping Label Zebra** (`commerce_shipping_label_zebra`) — support
  for producing labels on **Zebra** label printers. Enable it only if you print
  to Zebra hardware:

  ```bash
  drush en commerce_shipping_label_zebra -y
  ```

## Verify it worked

On its own this module has no visible UI — it is a service other modules use.
Confirm it is enabled at **Extend** (`/admin/modules`), then install and
configure a carrier module (such as Colissimo) that integrates with it. Label
generation will then appear on shipments within an order.
