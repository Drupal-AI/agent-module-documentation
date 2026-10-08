# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- **Commerce Checkout** (`commerce_checkout`) and **Commerce Order**
  (`commerce_order`) from Drupal Commerce.
- A **patch to Commerce core** — this module does not work without it (see below).
- For the optional **Commerce Admin Payment** submodule: the **Commerce Multiple
  Payments** module.

There are no extra PHP or third‑party library requirements.

## Required Commerce core patch

Commerce: Admin Checkout requires a patch to Commerce core from issue
**[#3204694]** (`https://www.drupal.org/project/commerce/issues/3204694`). Apply
the most recent patch attached to that issue. The recommended way is to add it to
your project's `composer.json` under `extra.patches` for `drupal/commerce` and let
[`cweagans/composer-patches`](https://www.drupal.org/docs/develop/using-composer/manage-dependencies#patches)
apply it automatically on install/update, so it survives future updates. Enable the
module only after the patch is applied.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_admin_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_admin_checkout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_admin_checkout -y
```

## Submodule — Commerce Admin Payment

The optional **Commerce Admin Payment** (`commerce_admin_payment`) submodule lets
administrators record manual "admin payments" that reduce the total a customer
pays — handy for employee discounts and similar adjustments. It **requires the
Commerce Multiple Payments module**, and it adds an **Apply Manual Payments**
checkout pane. Enable it only if you need that behaviour:

```bash
drush en commerce_admin_payment -y
```

## Assign permissions and add the checkout panes

1. On **People → Permissions** (`/admin/people/permissions`), grant `access
   checkout as a different user`, `edit cart items during checkout`, and
   `configure admin checkout settings` to trusted staff/admin roles only.
2. Under **Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout-flows`), add the **Assign Order to Customer**
   and **Order Items** panes (and **Apply Manual Payments** if you enabled the
   submodule) to the checkout flow your admins will use.

## Verify it worked

As a user with the admin‑checkout permissions, start a checkout, confirm you can
assign the order to another customer and add order items, and complete a test
order on their behalf.
