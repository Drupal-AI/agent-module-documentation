# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No module dependencies — it uses only Drupal core's Form API. The colour picker
  itself is the browser's native HTML5 control, so no external JavaScript library is
  needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fapi_colorpicker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fapi_colorpicker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fapi_colorpicker -y
```

The `colorpicker` element type is now available to any module or theme on the site.

## Verify it worked

Add an element of `#type => 'colorpicker'` to a form in your custom code (see "How to
use it" in the [overview](../index.md)) and confirm the native colour swatch and the
companion hex field render together, and that the submitted value is stored as a
lowercase `#rrggbb` string. Since the module has no admin UI, there is nothing else to
check in the interface.
