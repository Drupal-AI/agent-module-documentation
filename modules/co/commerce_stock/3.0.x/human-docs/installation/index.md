# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Drupal Commerce** — specifically the **Commerce Product**
  (`commerce_product`) and **Commerce Order** (`commerce_order`) modules, which
  Drupal enables as dependencies.

There are no third‑party Composer or PHP library requirements beyond Commerce
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_stock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_stock -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_stock -y
```

On its own, the base module only provides the **Always in stock** service (every
product is always available). For real inventory you'll want one or more
submodules below.

## Submodules — enable what you need

Commerce Stock is a framework; its practical features live in submodules. Enable
them with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Local stock** | `commerce_stock_local` | The main one for real inventory: a database‑backed **Local stock** service with actual stock levels, stock **locations** (warehouses), and recorded **transactions**. Enable this to track quantities. |
| **Commerce Stock Field** | `commerce_stock_field` | Exposes a **stock‑level field** on product variations so editors can view/set stock inline. |
| **Commerce Stock UI** | `commerce_stock_ui` | Adds **transaction entry forms** so warehouse staff can record stock receipts, sales, and movements. |
| **Commerce Stock Enforcement** | `commerce_stock_enforcement` | Actively **blocks out‑of‑stock items** in the cart and checkout. |

A typical inventory setup enables Local stock (and usually Field and UI):

```bash
drush en commerce_stock_local commerce_stock_field commerce_stock_ui -y
```

## Next step

Once the submodules you want are enabled, configure which stock service applies
to your products and how orders affect stock — see
[Configuration](../configuration/index.md).
