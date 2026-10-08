# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Color Field** module (`color_field`), which supplies the colour-picker
  input. Composer pulls it in automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admintoolbar_bgcolor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including pulling in Color Field — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admintoolbar_bgcolor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admintoolbar_bgcolor -y
```

Drupal enables Color Field at the same time if it is not already on. Once enabled,
choose the toolbar colour in the module's setting — see the [overview](../index.md)
for the per-environment workflow.
