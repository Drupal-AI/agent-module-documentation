# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **`drupal_threesixty_slider`** jQuery library (a Drupal build of the
  ThreeSixty slider). It is **not** shipped with the module — you add it yourself,
  as described below.
- On Drupal versions **below 9.2 only**, you also need the contributed
  **Libraries** module to load the library.

## Install with Composer

From the project root:

```bash
composer require drupal/field_slide_show_j360 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_slide_show_j360 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the jQuery library

Download the `drupal_threesixty_slider` library and extract it into your site's
libraries directory so the JavaScript file lands here:

```
/libraries/drupal_threesixty_slider/drupal-threesixty-slider.1.0.js
```

(On Drupal 7 the path is `/sites/all/libraries/drupal_threesixty_slider/…`, but
for Drupal 8 and above use `/libraries/…`.)

## Enable the module

```bash
drush en field_slide_show_j360 -y
```

## Verify it worked

Visit the status report at **Reports → Status report**
(`/admin/reports/status`). The module checks for the slider library and reports
whether it was found — resolve any warning there before configuring a field. Then,
on a **Manage display** screen, confirm **Slideshow j360** appears as a format
option for an image field.
