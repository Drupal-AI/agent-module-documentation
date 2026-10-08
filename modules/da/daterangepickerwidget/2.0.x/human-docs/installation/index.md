# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **jQuery UI DateRangePicker** JavaScript library, installed automatically
  through **Asset Packagist** (see below).
- To use the exposed-filter integration submodule, the **Better Exposed Filters**
  (`better_exposed_filters`) module and core **Views**.

## Set up Asset Packagist first

This module's JavaScript dependency is distributed as a Composer *asset*, so your
project has to know where to fetch it from. If your `composer.json` does not
already list Asset Packagist, add it to the `repositories` section before you
require the module:

```json
"repositories": [
    { "type": "composer", "url": "https://packages.drupal.org/8" },
    { "type": "composer", "url": "https://asset-packagist.org" }
]
```

You will typically also want the `composer/installers` and
`oomphinc/composer-installers-extender` plugins configured so asset libraries land
under `web/libraries`. The Drupal Composer project documents the full setup; if
`composer require` later complains it cannot find the JavaScript package, an
unconfigured Asset Packagist is almost always the cause.

## Install with Composer

From the project root:

```bash
composer require drupal/daterangepickerwidget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
JavaScript library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/daterangepickerwidget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en daterangepickerwidget -y
```

## Submodules — enable only what you need

The project ships two optional submodules. Enable them with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DateRangePicker Field** | `drpw_field` | The date-range field type and its widget, so content types can store a range picked with the widget. |
| **DateRangePicker BEF** | `drpw_bef` | Integration with **Better Exposed Filters**, so a View's exposed date filter can use the range picker. Requires the Better Exposed Filters module. |

For example, to add the Better Exposed Filters integration:

```bash
drush en drpw_bef -y
```

## Verify it worked

- With `drpw_field` enabled, go to **Structure → Content types → *(a type)* →
  Manage form display** for a date-range field — the DateRangePicker widget should
  be selectable.
- With `drpw_bef` enabled and a View that exposes a date filter, the picker should
  appear as a widget option in the exposed-filter settings under **Better Exposed
  Filters**.
- On the rendered form, the field should open a two-month calendar with preset
  range shortcuts down the side.
