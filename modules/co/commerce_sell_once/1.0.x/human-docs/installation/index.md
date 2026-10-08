# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Commerce Stock** (`commerce_stock`) installed and enabled — this module is a
  stock service that plugs into it.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_sell_once -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Commerce Stock if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_sell_once -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_sell_once -y
```

## Select it as the stock service

Commerce Sell Once has no settings form. To put it to work, go to Commerce
Stock's configuration (**Commerce → Configuration → Stock**) and set the
**stock service** to the Sell Once service for the store or product types that
should be limited to a single sale.

## Verify it worked

Create a product governed by the Sell Once stock service, then place a test order
for it. After that order completes, the product should no longer be available for
purchase — confirming the single-sale cap is in force.
