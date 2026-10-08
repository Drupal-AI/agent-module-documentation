# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- *(Optional)* The **Features** module, only if you want to import/revert
  Features via the `config_import.features_importer` service.

There are no third‑party PHP library requirements.

## Install with Composer

The Composer package name (`confi`) differs from the module machine name
(`config_import`). Require the package by its Composer name:

```bash
composer require drupal/confi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `config_import` (not `confi`):

```bash
drush en config_import -y
```

For the optional Features integration:

```bash
drush en features -y
```

## Verify it worked

Confirm the module is enabled and its Drush commands are available:

```bash
drush help --filter=config_import
```

You should see the module's config-import commands listed.
