# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No dependent modules, no PHP requirement, and no third-party Composer libraries.
- Intended for sites using Single Directory Components.

This is an early release (`1.0.0-alpha2`), so test it on a non-production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/sdc_css_relocator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdc_css_relocator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sdc_css_relocator -y
```

That is all there is to it — the module relocates component stylesheets into the
theme's CSS group automatically, with no configuration.

## Verify it worked

If you use CSS aggregation, rebuild the cache with `drush cr` and reload a page that
uses a Single Directory Component. Component styles should now sit with the theme's
CSS and apply in the correct order, rather than being overridden unexpectedly.
