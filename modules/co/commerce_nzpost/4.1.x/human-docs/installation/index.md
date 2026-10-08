# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Drupal **Commerce** (`commerce`) and **Commerce Shipping** (`commerce_shipping`)
  enabled — these are the module dependencies.
- An **NZ Post API key** with access to the RateFinder API. You can apply for one
  free by emailing `developer@nzpost.co.nz`.
- Package types with **dimensions and weight** so the rate query is accurate.

There are no additional third‑party Composer or PHP library requirements.

> If you are running the Drupal 10 build, read the module's included README for
> known limitations before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_nzpost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_nzpost -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_nzpost -y
```

Commerce and Commerce Shipping are enabled automatically as dependencies.

## Verify it worked

Go to **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`) and add a shipping method. The plugin list
should include **NZ Post**. Configuring it is covered in
[Configuration](../configuration/index.md).
