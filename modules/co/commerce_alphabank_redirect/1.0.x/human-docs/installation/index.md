# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Payment**
  (`commerce_payment`).
- An **Alpha Bank (Greece) merchant account** providing a merchant ID and a shared
  secret for the redirect integration.

There are no extra PHP or third‑party library requirements. (Only the older Drupal 7
version depended on the separate Commerce Static Checkout URL module; that isn't
needed here.)

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_alphabank_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_alphabank_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_alphabank_redirect -y
```

## About the shared secret

The Alpha Bank **shared secret** is the whole basis of trust for verifying
callbacks. This module does not integrate with the Key module — you enter the
secret directly into the gateway's **Shared secret** field during
[Configuration](../configuration/index.md), and it is stored in the gateway
configuration. Because of that, treat your Commerce configuration export as
sensitive (keep it out of public version control) and restrict who can administer
payment gateways. The secret is used only server-side to verify the bank's callback
digest; it is never sent to the customer's browser.

## Verify it worked

Continue to [Configuration](../configuration/index.md) to add the Alpha Bank
gateway. In the bank's test environment, place an order, complete payment on Alpha
Bank's hosted page, and confirm the payment is recorded as completed against the
order on return.
