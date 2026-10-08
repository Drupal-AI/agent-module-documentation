# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).

There are no third‑party PHP library requirements to install separately and no
module dependencies beyond core — the Punycode conversion library ships with the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/idna -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/idna -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en idna -y
```

## Verify it worked

Visit `/idna` in your browser and run a test conversion — enter an
internationalized domain and confirm it converts to Punycode (and back). From
code, `\Drupal::service('idna')` should return the conversion service.
