# Installation

## Requirements

- **Drupal 9.1+ or 10** (`core_version_requirement: ^9.1 || ^10`).
- **Drupal Commerce** with the **Commerce Tax** submodule (`commerce_tax`,
  version `>= 8.x-2.20`) enabled — this is the module's only dependency, and it is
  what supplies the tax types you attach conditions to.

There are no third‑party Composer or PHP library requirements.

> **Already on Commerce `^2.32` or newer?** You don't need this module — Commerce
> Tax has a built‑in conditions UI on that version.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_tax_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_tax_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Commerce Tax first (if it isn't already), then this module:

```bash
drush en commerce_tax commerce_tax_conditions -y
```

## Verify it worked

Go to **Commerce → Configuration → Tax types**
(`/admin/commerce/config/tax-types`) and edit any tax type. You should now see a
**Conditions** section on the form. Add a condition, save, and place a test order
to confirm the tax is applied only when the condition matches.
