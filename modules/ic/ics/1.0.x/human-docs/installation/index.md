# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **Image Comparison Slider** JavaScript library (`img-comparison-slider`),
  installed into your site's `/libraries` directory.

## Install with Composer

From the project root:

```bash
composer require drupal/ics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ics -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Install the JavaScript library

The formatter needs the Image Comparison Slider library on disk. The final file
must end up at `/libraries/img-comparison-slider/dist/index.js`.

The easiest route with Composer is to require the npm‑asset package (this assumes
your project is configured to resolve `npm-asset/*` packages, for example via the
Asset Packagist repository):

```bash
composer require npm-asset/img-comparison-slider
```

Alternatively, install it manually: run `npm pack img-comparison-slider`, then
extract the downloaded archive into `/libraries` so that the path above is
correct.

## Enable the module

```bash
drush en ics -y
```

To use the effect with Media entities, also enable the companion **Image
Comparison Slider for Media** submodule from **Extend** (or with `drush en`),
which ships inside this project.

## Verify it worked

Add the **Image Comparison Slider** formatter to a multi‑value image field on a
content type's **Manage display**, create a node with **two** images in that
field, and view it — you should see a draggable before/after slider. If the
images stack normally instead, re‑check the library path
(`/libraries/img-comparison-slider/dist/index.js`) and clear caches.
