# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **PHP 8.4** (`php_requirement: 8.4`).
- The **`endroid/qr-code`** PHP library, version **6.1 or newer** — pulled in automatically
  by Composer when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/endroid_qr_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the required
`endroid/qr-code` library and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/endroid_qr_code -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en endroid_qr_code -y
```

There are no submodules. Next, set the QR appearance on the
[Configuration](../configuration/index.md) page, then apply the **Endroid Qr Code** formatter
to a string or link field (see the ["How to use it"
section](../index.md#how-to-use-it) on the overview page).

> Do **not** use the old `endroid_qr_code` field type/widget for new fields — it is
> deprecated (removed in 5.0). Use a plain string or link field with the formatter instead.
