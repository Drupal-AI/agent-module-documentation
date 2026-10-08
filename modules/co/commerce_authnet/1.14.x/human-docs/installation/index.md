# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce` `^2.39 || ^3`). The module specifically
  needs Commerce's **Payment** (`commerce_payment`) and **Checkout**
  (`commerce_checkout`) submodules enabled — Drupal turns those on for you when you
  enable this module.
- The **`commerceguys/authnet`** PHP library (`^1.1.4`), which does the actual talking
  to Authorize.Net. Composer installs it automatically as a dependency.
- An **Authorize.Net account** — a developer/sandbox account for testing, and a real
  merchant account for live payments. The module cannot take payments without valid
  Authorize.Net credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_authnet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Drupal Commerce and
the `commerceguys/authnet` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_authnet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_authnet -y
```

This also enables `commerce_payment` and `commerce_checkout` if they were not already
on.

## Next step

The module ships no submodules and adds no settings page. Everything else happens when
you add a payment gateway — see [Configuration](../configuration/index.md).
