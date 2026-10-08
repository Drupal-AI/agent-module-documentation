# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **CRM Core** (`crm_core`) and its **Contact** submodule (`crm_core_contact`).
- **Commerce** — specifically the order module (`commerce_order`).
- No third‑party PHP libraries are required.

Composer resolves the CRM Core and Commerce requirements for you, but you will need
a working Drupal Commerce store for this integration to have orders to act on.

## Install with Composer

From the project root:

```bash
composer require drupal/crm_core_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update CRM Core,
Commerce, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crm_core_commerce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crm_core_commerce -y
```

Enabling the module also enables its CRM Core and Commerce dependencies if they are
not already on. **After enabling, you must choose which CRM Core contact bundle new
contacts use** before the integration will work — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → CRM Core → Commerce Settings**
(`/admin/config/crm-core/commerce/settings`). If the settings form loads and lets
you pick a CRM Core individual bundle, the module is installed correctly. After
configuring it, place a test order and confirm a matching CRM Core contact is
created or updated.
