# Installation

## Requirements

tapin needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Drupal Commerce** — both the base **Commerce** module (`commerce`) and
  **Commerce Order** (`commerce_order`) must be present and enabled.
- Core's **RESTful Web Services** module (`rest`), since the integration is built
  entirely from REST resources.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tapin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/tapin`, matches the
module's machine name, `tapin`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tapin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tapin -y
```

On install, tapin adds its three fields to the default commerce order type
(`field_tapin_order_id`, `field_tapin_check`, `field_barcode_tapin`) and installs
its REST resource configuration.

## Verify it worked

Log in as an administrator and confirm two things: the settings form is reachable
at **Configuration → System → tapin** (`/admin/config/system/tapin`), and the new
order fields appear under **Commerce → Configuration → Order types → Manage
fields** for your order type. Once those are present, continue to
[Configuration](../configuration/index.md) to set the token and grant the REST
permissions — the module does nothing useful until those steps are done.
