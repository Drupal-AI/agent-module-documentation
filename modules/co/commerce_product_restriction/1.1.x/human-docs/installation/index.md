# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Drupal Commerce** (`commerce`) and **Commerce Cart** (`commerce_cart`) — the
  cart/add-to-cart flow the restrictions attach to.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_restriction -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_restriction -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_restriction -y
```

## Set up the restriction field

Enabling the module is only the first step — restrictions are added through a field:

1. Go to a product type (or product variation type) and open **Manage fields**.
2. Add a field of type **Plugin → Product restriction**.
3. On the same type's **Manage form display**, set that field's widget to
   **"Product restrictions"**. This is easy to miss, and without it the restriction
   options will not show on the product edit form.
4. Edit a product or variation of that type and configure the restrictions you want.

## Verify it worked

Edit a product of a type where you added the restriction field. You should be able
to add one or more restriction plugins (dates, roles, users, password, quantity,
prior purchase) and give each a message. Add a restriction that should block you,
then view the product on the storefront and confirm the add-to-cart button is
replaced by your message. Remember that enforcement is at the form level only — see
the caveat in the [overview](../index.md) before relying on it for hard access
control.
