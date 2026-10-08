# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Photo-Sphere-Viewer** JavaScript library (installed separately, see below).

## Install with Composer

From the project root:

```bash
composer require drupal/image_field_360 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_field_360 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Add the JavaScript library

The panorama is rendered by the third-party **Photo-Sphere-Viewer** library (by
Jérémy Heleine), which is **not** bundled with the module. Install it into your site's
`/libraries` directory (in the Drupal root, not inside `/core`). Only two files are
required:

- `three.min.js`
- `photo-sphere-viewer.min.js`

Check the module's `README` for the exact expected paths.

## Enable the module

```bash
drush en image_field_360 -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

On a content type with an image field, set that field's formatter to the **360°**
formatter under **Manage display**, upload an **equirectangular** image to a piece of
content, and view it. You should see a draggable 360° panorama. If the viewer does not
appear, confirm the Photo-Sphere-Viewer library files are present at the paths the
`README` specifies, and clear the cache. See the
["How to use it"](../index.md#how-to-use-it) section for the full walkthrough.
