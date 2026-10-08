# Installation

## Requirements

SVG Pan Zoom needs two Drupal modules and one JavaScript library:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — part of the standard install.
- **SVG Image** (`svg_image`) — so image fields accept SVG uploads.
- The **svg-pan-zoom** JavaScript library, version **3.6.1 or higher**
  (`ariutta/svg-pan-zoom`), installed into your site's libraries directory.

The module works without jQuery. There are no PHP library requirements.

## Install the svg-pan-zoom library

Download the svg-pan-zoom library (3.6.1+) and place it in your site's `libraries`
directory so the file is available at, for example,
`/libraries/svg-pan-zoom/dist/svg-pan-zoom.min.js`. You can fetch it from its
[project page](https://github.com/ariutta/svg-pan-zoom) or via a front‑end
package manager. The formatter's JavaScript initialises this library on the
rendered elements, so the module will not do anything useful until the library is
present.

## Install the module with Composer

From the project root:

```bash
composer require drupal/svg_pan_zoom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
`svg_image` dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_pan_zoom -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_pan_zoom -y
```

## Upgrading from 8.x-1.x

If you are coming from the old `8.x-1.0-x` release, you can upgrade straight to
2.x. There is no significant change — the version number was bumped only to switch
the project to semantic versioning.

## Verify it worked

Go to an image field's **Manage display** screen (for example
**Structure → Content types → Article → Manage display**) and confirm that
**Svg Pan Zoom** appears in the field's formatter dropdown. See
[Configuration](../configuration/index.md) to set it up.
