# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Facets** module (`facets`) enabled.
- The **Facets Range Widget** submodule/module (`facets_range_widget`) enabled — the
  slider widgets build on it.
- The **noUiSlider** JavaScript library (version 15), installed separately (see
  below).

## Install with Composer

From the project root:

```bash
composer require drupal/facets_range_nouislider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_range_nouislider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the noUiSlider library

The sliders need the noUiSlider JavaScript library, which is not bundled with the
module. Install it from Asset Packagist with Composer:

```bash
composer require "npm-asset/nouislider:^15"
```

If your project does not already use Asset Packagist, add it to `composer.json`
first (as the Facets Range NoUiSlider project page describes). Distributions such as
Lightning or Drupal Commerce already have it configured, so the single `composer
require` above is enough.

## Enable the module

```bash
drush en facets_range_nouislider -y
```

Make sure `facets` and `facets_range_widget` are enabled as well — they are the
module's dependencies.

## Verify it worked

Edit a numeric range facet at **Configuration → Search and metadata → Facets**. The
noUiSlider widget (and the range noUiSlider variant) should appear in the facet's
**widget** options. Select it, save, and confirm the slider renders and drags
smoothly on the search page — if it does, the noUiSlider library loaded correctly.
