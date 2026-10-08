# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.0** or newer.
- **Drush** to run the warming commands (they are the intended way to populate
  the queues, and are meant to be called from CI or cron).
- For product‑page warming: a working **Drupal Commerce** install, plus the
  bundled **Microwave Commerce** submodule (see below).

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/microwave -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/microwave -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en microwave -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Microwave Commerce** | `microwave_commerce` | Warming of Drupal Commerce product pages. Adds the `drush microwave:process_commerce_product_urls` (`mpcpu`) command and the `microwave_commerce_product_cron` queue worker, and lets you select which product bundles to warm. Enable it only if you run Commerce. |

Enable it when you need product warming:

```bash
drush en microwave_commerce -y
```

## Verify it worked

Log in as a user with the **Administer site configuration** permission and visit
**Configuration → System → Microwave** (`/admin/config/system/microwave`). If the
settings form loads, the module is installed. Nothing is warmed yet — continue to
[Configuration](../configuration/index.md) to choose targets and run the warming.
