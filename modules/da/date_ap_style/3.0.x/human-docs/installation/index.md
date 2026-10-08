# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library requirements.

The [Smart Date](https://www.drupal.org/project/smart_date) module is an
*optional* integration — if you have it, the `daterange_ap_style` formatter also
works on `smartdate` fields. You do not need it otherwise.

## Install with Composer

From the project root:

```bash
composer require drupal/date_ap_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_ap_style -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_ap_style -y
```

That is all it takes. The two **AP Style** field formatters become available on
every bundle's *Manage display* page immediately, and the `{{ …|ap_style }}` Twig
filter is ready to use. To choose your site-wide defaults and apply the formatters,
see the *How to use it* section on the [overview page](../index.md).
