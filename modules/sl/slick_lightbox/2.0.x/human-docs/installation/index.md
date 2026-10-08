# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- The **Slick** module, version **3.x** (`drupal/slick`, `^3.0`), which itself depends
  on **Blazy**. Composer pulls Slick (and Blazy) in automatically.
- The third-party **slick-lightbox** JavaScript/CSS library (from
  github.com/mreq/slick-lightbox) installed in your site's `/libraries` directory —
  see below. Without it the lightbox will not work.
- To edit the shared Slick optionset in the UI you also need the **Slick UI**
  sub-module enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/slick_lightbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in Slick and Blazy.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slick_lightbox -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Install the front-end library

Download the **slick-lightbox** library and place it so that the built files are at:

```
/libraries/slick-lightbox/dist/slick-lightbox.min.js
/libraries/slick-lightbox/dist/slick-lightbox.min.css
```

(Source: github.com/mreq/slick-lightbox.) The module's status-report check surfaces an
error if the library is not found, so visit **Reports → Status report**
(`/admin/reports/status`) to confirm it is detected.

## Enable the module

```bash
drush en slick_lightbox -y
# optional, to edit the Slick optionset in the UI:
drush en slick_ui -y
```

You can also enable modules from **Extend** (`/admin/modules`).

## What happens next

Nothing changes visually until you select **Image to Slick Lightbox** as the Media
switcher on a field or on the Blazy Filter. See the
[overview](../index.md#how-to-use-it) for those steps and for tuning the shared Slick
optionset.
