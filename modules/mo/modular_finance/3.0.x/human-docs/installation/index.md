# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No PHP version constraint beyond what your Drupal core requires.
- **No module dependencies** and no third‑party PHP or JavaScript libraries bundled
  with Drupal — the Modular Finance widget JavaScript is loaded client‑side from the
  vendor.
- **Widget and client tokens supplied by Modular Finance** — you get these from
  Modular Finance for your investor‑relations account.

## Install with Composer

From the project root:

```bash
composer require drupal/modular_finance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modular_finance -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modular_finance -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to enter your
client token, create at least one Modular finance type, and place the block. Once a
block is placed and pointed at a type, visit a page that shows it: the widget should
render in the browser and, if you inspect the page, you will find the token pushed
into `drupalSettings.modularFinance`.
