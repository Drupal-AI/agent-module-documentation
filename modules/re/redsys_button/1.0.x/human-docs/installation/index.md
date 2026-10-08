# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Redsys merchant account** (merchant code / FUC, terminal, and secret key
  from your bank).
- **HTTPS** in production — you are handling payment traffic.
- For the Commerce integration: **Drupal Commerce** (enable the
  `commerce_redsys_button` submodule).

## Install with Composer

From the project root:

```bash
composer require drupal/redsys_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redsys_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redsys_button -y
```

## Submodules

- **`commerce_redsys_button`** — adds Redsys as an off‑site payment gateway for
  **Drupal Commerce**. Enable it only if you run Commerce:

  ```bash
  drush en commerce_redsys_button -y
  ```

  Then add and configure the gateway under **Commerce → Configuration → Payment
  gateways**.

## Verify it worked

Log in as an administrator and open **Configuration → System → Redsys settings**
(`/admin/config/system/redsys-settings`). The Redsys configuration form should
load, ready for your merchant credentials — see
[Configuration](../configuration/index.md). Always test against the Redsys **test
environment** before switching to production.
