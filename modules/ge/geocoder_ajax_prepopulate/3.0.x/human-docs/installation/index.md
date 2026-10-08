# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Geocoder Field** submodule (`geocoder_field`) from the **Geocoder**
  project. This module depends on `geocoder_field` specifically, and you should
  have a working Geocoder configuration (a provider and field mapping) before
  this module does anything useful.
- **Version note:** use the `3.x` release with **Geocoder 3.x/4.x**. (The `1.x`
  branch is for Geocoder 2.x.)

There are no third‑party PHP library requirements for this module itself, though
your chosen geocoding provider may need its own credentials configured in
Geocoder.

## Install with Composer

From the project root:

```bash
composer require drupal/geocoder_ajax_prepopulate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geocoder_ajax_prepopulate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geocoder_ajax_prepopulate -y
```

Drupal will ensure `geocoder_field` is enabled as a dependency.

## Verify it worked

Open a content form that has a Geocoder‑configured address field with a geofield
target. Enter an address; after the field settles you should see the coordinates
(or formatted address) prefill over AJAX, before you save the form. If the target
fields populate as you type rather than only on save, the module is working. If
nothing happens, double‑check that Geocoder itself is correctly configured — this
module only changes the timing of a geocoding that Geocoder is already set up to
perform.
