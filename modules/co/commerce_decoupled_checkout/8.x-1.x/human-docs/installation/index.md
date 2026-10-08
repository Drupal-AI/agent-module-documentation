# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Payment** (`commerce_payment`) and **Checkout**
  (`commerce_checkout`) modules enabled — these are the module's dependencies.
- A configured Commerce **on-site payment gateway** for whichever provider your
  front end will use (the module has been used with PayPal, Stripe, Global Payments,
  and Direct Debits).
- The core **RESTful Web Services** module (and, most conveniently, the contributed
  **REST UI** module) to enable and configure the endpoints.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_decoupled_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_decoupled_checkout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_decoupled_checkout -y
```

## Verify and configure

Enabling the module only registers the REST resources; it does not switch them on.
Before a front end can call them, enable each resource, pick its request format and
**authentication provider**, and grant its `restful post …` permission to the
appropriate roles — see the [overview](../index.md) for the step‑by‑step. Serve the
API over HTTPS.
