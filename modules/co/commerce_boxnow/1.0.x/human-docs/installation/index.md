# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Shipping** module enabled
  (`commerce_shipping`). Drupal enables this dependency for you when you turn on
  the module.
- Valid **BOX NOW API credentials** for your merchant account.

The **Address** and **Commerce Checkout** modules are recommended companions for a
smooth shipping‑address and checkout experience. There are no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_boxnow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_boxnow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_boxnow -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Shipping methods**, click to
add a shipping method, and confirm **BoxNow Shipping** appears as an available
type. Then continue to [Configuration](../configuration/index.md).
