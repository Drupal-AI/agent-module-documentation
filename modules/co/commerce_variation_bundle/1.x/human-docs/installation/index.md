# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Product** (`commerce_product`).

Optional integrations:

- **Commerce Stock** (`commerce_stock`) plus the companion *Commerce Variation
  Bundle Stock* project, for dynamic bundle stock based on component quantities.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_variation_bundle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_variation_bundle -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_variation_bundle -y
```

Commerce and Commerce Product are enabled automatically as dependencies if they
aren't already.

## Submodule

- **`commerce_variation_bundle_attributes`** — uses attributes dynamically from the
  referenced bundle items. It is **experimental**; enable it only if you need that
  behavior and can accept the risk:

  ```bash
  drush en commerce_variation_bundle_attributes -y
  ```

## Verify it worked

After enabling, follow the post‑installation setup in the
[overview](../index.md) — create a product variation type and select the
**Variation bundles** trait on it. If the trait appears in the variation type's
form, the module is installed correctly.
