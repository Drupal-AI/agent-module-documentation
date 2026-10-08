# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: ^8.0`).
- Core's **Field** module (`field`) enabled — this is the module's only Drupal
  dependency, and it is enabled by default on a standard Drupal install. The whole
  point of the module is the **Address** field it adds, which you place with the Field
  UI.
- The **`commerceguys/addressing`** PHP library (`^2.1.1`). This is what supplies the
  per‑country address formats, labels, and validation rules. You don't download it
  by hand — installing the module with Composer pulls it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/address -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
`commerceguys/addressing` library and any other shared dependencies. Installing
Address with Composer (rather than dropping the module in by hand) is important here,
precisely because it needs that PHP library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address -y
```

Enabling the module registers the **Address**, **Country** (`address_country`), and
**Zone** (`address_zone`) field types along with their widgets and formatters. Nothing
changes on your content forms yet — you add an Address field where you need one. See
[Configuration](../configuration/index.md) for that.

## Submodules

Address ships **no submodules** — the base module is everything you need.
