# Installation

## Requirements

- **Drupal core** — the module's info file requires `^10.3 || ^11`. (Its
  `composer.json` states `^10.4 || ^11`; the **info file** is what Drupal enforces
  at install, but be aware of the small mismatch.)
- **Drupal Commerce** `^2.4 || ^3.0`, providing **Commerce** (`commerce`) and
  **Commerce Payment** (`commerce_payment`).
- **Profile** (`profile`) — customer profiles, where PO authorisation attaches.
- Core **File** (`file`) — so a PO document can be attached to an order.

Drupal will pull the module dependencies in automatically, but Commerce and
Profile must be available in your codebase.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_purchase_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_purchase_order -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_purchase_order -y
```

Enabling the module adds a **Purchase Orders Authorized** field to the User
entity. By default this field is **not displayed** — see
[Configuration](../configuration/index.md) for how to expose it.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm a Purchase Order plugin appears in the list. Then continue to
[Configuration](../configuration/index.md).
