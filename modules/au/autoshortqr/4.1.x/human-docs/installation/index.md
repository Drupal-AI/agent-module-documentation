# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Barcodes** module (`barcodes:barcodes`) — a required dependency; AutoShortQR
  renders its QR codes through it (built on `drupal/barcode`).

## Install with Composer

From the project root:

```bash
composer require drupal/autoshortqr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Barcodes module
and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autoshortqr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autoshortqr -y
```

Enabling AutoShortQR also enables Barcodes if it isn't already on. The module ships
no submodules. Once enabled, a self‑referencing QR code for the current page becomes
available — see [How to use it](../index.md#how-to-use-it).
