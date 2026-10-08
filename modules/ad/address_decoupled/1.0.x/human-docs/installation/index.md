# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Address** module (`address`) and **RESTful Web Services** module
  (`rest`) enabled — both are required dependencies. Composer and Drush pull them
  in automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/address_decoupled -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `address` and `rest` dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_decoupled -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_decoupled -y
```

Drush enables the `address` and `rest` dependencies at the same time.

## Optional: the Commerce submodule

If your site uses Drupal Commerce, enable the bundled submodule for
Commerce-specific decoupled address support:

```bash
drush en address_decoupled_commerce -y
```

After enabling, configure and access-control the REST resources through core's REST
configuration (or the REST UI module), then consume them from your front end — see
[How to use it](../index.md#how-to-use-it).
