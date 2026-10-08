# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

The Composer package name uses the Spanish spelling **`accesibilidad`**:

```bash
composer require drupal/accesibilidad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/accesibilidad -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Watch out for the name difference: the project is `accesibilidad`, but the Drupal
**machine name** is `accesibility`. Enable it by the machine name:

```bash
drush en accesibility -y
```

Once enabled, the accessibility widget is attached automatically to every
non-admin page — there is no per-page setup. The only optional step is editing the
two helper messages on the settings form; see
[Configuration](../configuration/index.md).
