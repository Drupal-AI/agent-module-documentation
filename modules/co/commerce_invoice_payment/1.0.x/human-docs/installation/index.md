# Installation

## Requirements

Commerce Invoice Payment sits on top of several Commerce modules:

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- **Commerce** (`commerce`) and **Commerce Order** (`commerce_order`).
- **Commerce Invoice** (`commerce_invoice`) — the module that produces the
  invoices this one makes payable.
- **Views Bulk Operations** (`views_bulk_operations`) — provides the bulk‑action
  framework the "Pay invoice" action uses.

Drupal will pull these in as dependencies when you install the module with
Composer. This project **is** covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_invoice_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_invoice_payment -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_invoice_payment -y
```

If you want a ready‑made example to study, the project also ships an
**example submodule** you can enable:

```bash
drush en commerce_invoice_payment_example -y
```

## Verify it worked

After enabling, edit any View that lists invoices and open its bulk‑operations
field settings — **Pay invoice** should now appear in the list of selectable
actions. You can also check **People → Permissions** for the new
**`use pay invoice action`** permission. See the "How to use it" section of the
[overview](../index.md) for wiring it all together.
