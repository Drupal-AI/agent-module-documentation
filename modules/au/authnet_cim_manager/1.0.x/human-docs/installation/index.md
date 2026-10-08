# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Authorize.Net merchant account** with CIM enabled, and its API credentials
  (API login ID and transaction key).
- No module dependencies or third-party Composer/PHP library requirements are declared.

Because this module processes payment card data, review your **PCI-DSS obligations**
before putting it into production.

## Install with Composer

From the project root:

```bash
composer require drupal/authnet_cim_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/authnet_cim_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en authnet_cim_manager -y
```

## Next steps

Before using it, configure your merchant credentials and — importantly — restrict who
can reach the CIM creation form, which defaults to the weak `access content`
permission. See [Configuration](../configuration/index.md).
