# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce's order module** (`commerce_order`, version 3.0.0 or newer),
  which is a hard dependency. In practice this means you already have Drupal
  Commerce installed.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_view_receipt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_view_receipt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_view_receipt -y
```

There is no configuration step. As soon as the module is on, the **Receipt** tab
appears on order pages and the customer receipt route becomes available. Access is
handled entirely by Commerce's existing order permissions.

## Optional — PDF download with Entity Print

To add a **Download PDF** action to the receipt pages, install and enable the
Entity Print module:

```bash
composer require drupal/entity_print -W
drush en entity_print -y
```

Entity Print is only a *suggestion*, not a hard dependency. Without it, receipts
still display in the browser; you just won't have the PDF action.

## Verify it worked

Open an existing order under **Commerce → Orders** and look for the **Receipt**
tab. Click it — the order's receipt should render in the page. If you enabled
Entity Print, you should also see a **Download PDF** action. See the
[overview](../index.md) for the customer‑facing receipt and the Views link field.
