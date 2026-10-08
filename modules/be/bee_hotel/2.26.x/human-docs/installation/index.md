# Installation

## Requirements

- **Drupal core `^9.4 || ^10.2 || ^11`**.
- The booking and commerce stack it builds on: **BAT** (`bat`), **BEE** (`bee`),
  **Commerce Product** (`commerce_product`), and **Commerce Store**
  (`commerce_store`). Through BEE it also pulls in the wider BAT and Commerce
  dependencies.

This is a large application, not a small add-on — expect to install and configure
a substantial stack, and plan to keep all of it updated.

## Install with Composer

From the project root:

```bash
composer require drupal/bee_hotel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
BAT, BEE and Commerce dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bee_hotel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bee_hotel -y
```

Drupal will enable the BAT, BEE and Commerce dependencies alongside it.

## Submodules — enable only what you need

BEE Hotel ships many optional submodules. Enable them individually with
`drush en`:

| Submodule | What it adds |
|-----------|--------------|
| `beehotel_samplehotel` | A sample hotel to explore how everything fits together — handy when starting out. |
| `beehotel_addtocart` | Add-to-cart behaviour for bookings. |
| `beehotel_event` | Event-related booking features. |
| `beehotel_happening_today` | A "happening today" overview. |
| `beehotel_ical` | iCal feeds for bookings/availability. |
| `beehotel_pricealterator` / `beehotel_pricealterators` | The dynamic/seasonal pricing plugin system and its bundled alterators. |
| `beehotel_sps` | Additional pricing/search support. |
| `beehotel_vertical` | Vertical-market presentation helpers. |
| `beehotel_utils` | Shared utilities used by the suite. |
| `beehotel_upgrade` | Upgrade helpers between versions. |

For example, to try the suite with sample data:

```bash
drush en beehotel_samplehotel -y
```

After enabling, configure units, availability and pricing on the BEE Hotel
settings page — see [Configuration](../configuration/index.md).
