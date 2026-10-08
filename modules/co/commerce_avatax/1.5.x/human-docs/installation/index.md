# Installation

## Requirements

- **Drupal 9.3, 10.1, or 11** (`core_version_requirement: ^9.3 || ^10.1 || ^11`).
- **PHP 8 or newer** (`php: >=8`).
- **Drupal Commerce** (`drupal/commerce`, `^2.16 || ^3`), with these Commerce
  submodules enabled — they are declared dependencies, so Drupal enables them
  with the module: **Commerce Core** (`commerce`), **Order** (`commerce_order`),
  **Store** (`commerce_store`), and **Tax** (`commerce_tax`).
- An **Avalara AvaTax account** — an account ID and license key. You do not need
  these to install the module, but you do to actually calculate tax.
- Optional but recommended: **Commerce Shipping** (`drupal/commerce_shipping`,
  `^2.0@rc || ^3`) — enables tax on shipping lines and address validation on the
  admin shipment form.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_avatax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_avatax -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_avatax -y
```

Enabling the module installs the `avatax` Commerce tax type and adds the extra
fields (store company code, product‑variation tax code, user customer code and
exemption fields). Next, enter your Avalara credentials on the settings form —
see [Configuration](../configuration/index.md).

## A note on credentials

Your Avalara **account ID** and **license key** are secrets. Rather than typing
them directly and committing them, store them as environment variables and
override them per environment (for example via `settings.php`
`$config['commerce_avatax.settings'][…]` or an environment‑specific override), so
they never end up in exported configuration or version control.

## Submodules

None — Commerce AvaTax ships as a single module.
