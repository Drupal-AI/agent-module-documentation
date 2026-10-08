# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies.
- The **SVG.js** JavaScript library. By default the module loads it from the
  jsDelivr CDN, so nothing else is required to get started; for production you can
  install a local copy (see below).

Note that the released branch is an alpha (`1.0.0-alpha1`) and the project is
**not covered by Drupal's security advisory policy**, so test before relying on
it in production.

## Install the module with Composer

From the project root:

```bash
composer require drupal/svgjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svgjs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svgjs -y
```

That is enough to start: with no local library present, the module loads SVG.js
from the jsDelivr CDN automatically, and the `SVG()` API becomes available on
every page.

## Optional: install the library locally (recommended for production)

Loading from a CDN makes an external request on every page. To serve the library
from your own site instead — better for privacy, offline use, and content‑security
policies — download SVG.js and place it in your site's `libraries` directory so
the file is available at:

```
/libraries/svgjs/dist/svg.min.js
```

When the module detects a local copy it uses that instead of the CDN. Installing
locally also lets you **pin the SVG.js version** by managing the file yourself.

## Verify it worked

On any page, open your browser's developer console and type `SVG` — it should be a
defined function rather than `undefined`. Then attach a small behavior (see the
example on the [main guide](../index.md)) to confirm you can draw and animate an
SVG element.
