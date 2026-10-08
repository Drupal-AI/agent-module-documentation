# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Tax** submodule (`commerce_tax`)
  enabled — the only dependency.
- Outbound HTTPS access from your server to the Washington State Department of
  Revenue's rate‑lookup web service, so the module can fetch live rates.

There are no third‑party Composer or PHP library requirements, and no API key is
needed — the Department of Revenue lookup is a public service.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_tax_wa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_tax_wa -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_tax commerce_tax_wa -y
```

## Verify it worked

Go to **Commerce → Configuration → Tax types**
(`/admin/commerce/config/tax-types`) and click **Add tax type**. If
**Washington State tax service** appears as an option, the module is installed.
Continue to [Configuration](../configuration/index.md) to set it up.

> **Note:** this module targets Drupal Commerce 2.x/3.x. The older `8.x-1.x`
> branch was for Commerce up to 8.x‑2.7, and `8.x-2.x` for Commerce 8.x‑2.8 and
> up; use the `3.0.x` branch (this one) on Drupal 10/11.
