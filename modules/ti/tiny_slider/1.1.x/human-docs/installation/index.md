# Installation

Installing Tiny Slider is a **two‑step** job: install the Drupal module, then
download the Tiny Slider JavaScript library it wraps.

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Field** (`field`) and **Image** (`image`) modules — Drupal enables
  these automatically as dependencies.
- The **Tiny Slider 2 JavaScript library** placed at `/libraries/tiny-slider`
  (see below). The module does not ship it.

There are no third‑party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tiny_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tiny_slider -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tiny_slider -y
```

## Download the Tiny Slider library

Until the library is present, sliders will not initialize on the front end and
the site's status report shows an error. The easiest way to install it is the
bundled Drush command:

```bash
drush tiny_slider:download   # or the short alias: drush ts:dl
```

This downloads Tiny Slider v2.9.3 from GitHub and extracts it to
`libraries/tiny-slider`, leaving `libraries/tiny-slider/dist/tiny-slider.js` in
place. The command needs outbound HTTP access from the server.

**Prefer to do it by hand?** Download the Tiny Slider 2 release archive yourself
and extract it so that the file `dist/tiny-slider.js` ends up at
`libraries/tiny-slider/dist/tiny-slider.js`.

## Verify it worked

Visit **Reports → Status report** (`/admin/reports/status`). Once the library is
in place, the Tiny Slider requirement turns green. Then configure a slider on a
field's *Manage display* screen or in a View — see the
[How to use it](../index.md#how-to-use-it) section.
