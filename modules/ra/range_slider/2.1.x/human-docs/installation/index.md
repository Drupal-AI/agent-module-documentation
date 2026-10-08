# Installation

## Requirements

Range Slider is very lightweight:

- **Drupal 9.2 or newer** (`core_version_requirement: >=9.2`).
- No other contrib modules are required. To use the Webform element you will of
  course need the Webform module installed, and to use the field widget you need
  a core numeric field (integer, decimal, or float).
- No Composer library or PHP-version requirements. The rangeslider.js JavaScript
  library is loaded from a CDN at runtime rather than installed via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/range_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/range_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en range_slider -y
```

There are no submodules and no configuration form. Once enabled, the **Range
Slider** widget appears as an option on the *Manage form display* screen for any
integer, decimal, or float field, and the **Range Slider** element becomes
available in Webform. See the [overview](../index.md) for how to put it to work.
