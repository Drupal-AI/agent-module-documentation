# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Commerce Shipping** (`commerce_shipping`) enabled — this is the only supported
  companion module and the source of the shipping estimates. Drupal Commerce and
  its dependencies come with it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_estimate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_cart_estimate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_estimate -y
```

## Verify it worked

Enabling the module does not change the cart page on its own — you still have to
add the estimate form to the cart view (see
[the cart form view steps](../index.md#how-to-use-it)). Once you have done that,
visit your cart with at least one product in it: the estimate form should appear
where you placed it (typically the footer). Enter a country and postal code, and
you should see an estimated shipping and tax total. Compare it against a real
checkout to confirm the numbers match.
