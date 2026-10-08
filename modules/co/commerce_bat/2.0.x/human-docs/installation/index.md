# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** — specifically `commerce_product`, `commerce_order`,
  `commerce_cart`, `commerce_store`, and `commerce_price`.
- **BAT (Booking and Availability Tools)** modules: `bat`, `bat_unit`,
  `bat_event`.
- Core's **Datetime Range** module (`datetime_range`).
- JavaScript libraries: **FullCalendar** (v6.1.11+ recommended for the best
  calendar/timeslot UX) and **Flatpickr** (v4.6.13+, a lighter date picker).
  These can load from a CDN fallback or from local copies.

Composer will pull in the module's Drupal dependencies; make sure the BAT modules
and the JS libraries are present as well.

> **Version warning:** Do **not** use `1.5.0`, or any release between `2.0.0` and
> `2.2.0-alpha2`. Those versions have a checkout error on Drupal 10 (a
> transaction API call that only exists on Drupal 11). Install a version outside
> that range.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_bat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_bat -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_bat -y
```

This also enables its Commerce and BAT dependencies.

## Verify it worked

Go to **Administration → Commerce → Configuration → BAT / Availability**
(`/admin/commerce/config/commerce-bat`). You should see the settings overview where you
map variation types to booking modes. From there, continue to
[Configuration](../configuration/index.md).
