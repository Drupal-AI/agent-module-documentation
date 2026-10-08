# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** and **Field** modules (enabled by default on standard
  installs) so you have an image field to attach the formatter to.
- The **js‑cloudimage‑360‑view** JavaScript library, installed into `/libraries`
  (see below). The module does not bundle it.

## Install with Composer

From the project root:

```bash
composer require drupal/js_cloudimage_360_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/js_cloudimage_360_view -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the 360° view library

Download the **3.2.0** release of the js‑cloudimage‑360‑view library, extract it,
rename the extracted `js-cloudimage-360-view-3.2.0` folder to
`js-cloudimage-360-view`, and place it in your `/libraries` folder so this path
exists:

```
/libraries/js-cloudimage-360-view/build/js-cloudimage-360-view.min.js
```

## Enable the module

```bash
drush en js_cloudimage_360_view -y
```

## Submodules

- **JS Cloudimage 360 view — Lozad Lazyload**
  (`js_cloudimage_360_view_lozad_lazyload`) adds lazy‑loading of the 360° view
  images (via the Lozad library), so the frames load only when the view scrolls
  into sight. Enable it only if you want that behavior:

  ```bash
  drush en js_cloudimage_360_view_lozad_lazyload -y
  ```

## Verify it worked

Go to a bundle's **Manage display** and confirm the **Cloudimage 360 view**
formatter is available for an image field. After uploading a set of frames to that
field, view the content — the images should render as a single, drag‑to‑rotate
360° view. See "How to use it" in the [overview](../index.md) for the full setup.
