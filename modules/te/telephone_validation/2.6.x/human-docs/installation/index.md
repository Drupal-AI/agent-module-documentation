# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Telephone** module (`telephone`) enabled — this is the field type the
  module validates. Drupal enables it automatically as a dependency.
- The **`giggsey/libphonenumber-for-php`** library (version `~8.0`), which does the
  actual number parsing and validation. Composer installs it for you when you
  require the module — there is nothing to download by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/telephone_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`giggsey/libphonenumber-for-php` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telephone_validation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone_validation -y
```

There are no sub‑modules. Enabling the module does not switch validation on by
itself — it is opt‑in per field, and you can also set a site‑wide default. Head to
[Configuration](../configuration/index.md) for both.
