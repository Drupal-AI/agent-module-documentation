# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Shipping**
  (`commerce_shipping`).
- The **jQuery UI Datepicker** module (`jquery_ui_datepicker`) — the date picker
  library must be present for the booking UI.
- Core's **Datetime Range** module (`datetime_range`).

There are no additional third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_timeslots -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce Shipping,
the jQuery UI Datepicker module, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_timeslots -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_timeslots -y
```

Commerce, Commerce Shipping, jQuery UI Datepicker, and Datetime Range are enabled
automatically as dependencies if they aren't already.

## Verify it worked

Go to **Commerce → Time slots** (`/admin/commerce/timeslots`). If the time‑slot
admin pages load, the module is installed. Then continue to
[Configuration](../configuration/index.md) to define your first slots and wire the
selection into checkout.
