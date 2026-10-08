# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal Commerce with **Tax** (`commerce_tax`) enabled — the only module
  dependency, enabled automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_nz -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_nz -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_nz -y
```

Commerce Tax is enabled automatically as a dependency.

## Verify it worked

The module needs no configuration. Wherever Commerce Tax lets you pick a tax number
type, **New Zealand GST** should now appear in the list of available types. Entering
an NZ GST number there will be validated by the module.
