# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Product** (`commerce_product`) —
  these are the modules that provide product variations and the add-to-cart form this
  widget plugs into. Drupal enables them as dependencies when you turn on this module.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cpv_radio_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cpv_radio_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cpv_radio_widget -y
```

## Verify it worked

1. Confirm Commerce and Commerce Product are present at **Extend**
   (`/admin/modules`).
2. Follow "How to use it" in the [overview](../index.md): set the **Product variation
   radio** widget on the *Purchased entity* field of your order item type's *Add to
   cart* form display, choose a display mode, and save.
3. Visit a product with more than one variation — the selector should render as radio
   buttons instead of a dropdown.
