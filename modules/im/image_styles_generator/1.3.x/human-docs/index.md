# Image Styles Generator — manual setup guide

**Image Styles Generator** (`image_styles_generator`) pre-generates ("warms")
image-style derivatives for every image on your site, so those resized/cropped
versions already exist on disk instead of being built the first time a visitor
requests them. Normally Drupal builds a derivative lazily on first hit, which
makes the first person to load an image-heavy page pay the CPU cost; warming the
derivatives up front — in a deploy step, a CI/CD pipeline, or after flushing image
styles — moves that cost off your visitors.

The module is **command-line only**: it has no admin UI, no settings form and no
permission. It adds one Drush command that scans every published image file, loads
your image styles, and writes each derivative to disk, with a progress bar. It
depends on core's **Image** module. One optional submodule,
**image_styles_generator_webp**, decorates the warmer so it also writes a WebP
copy of each derivative (it needs the separate `webp` module).

This guide is written for a **human** working at the command line. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the WebP submodule.

## Where it lives in the admin menu

Nowhere — this module has no administration pages. Everything happens through the
Drush command below.

## How to use it

The command warms derivatives for **every published image file** on the site. Run
it from your project root (prefix with `ddev` on a DDEV host):

```bash
# Warm every image style for every image:
drush image:derive:multiple

# Skip derivatives that already exist on disk (idempotent, much faster re-runs):
drush image:derive:multiple --skip-existing

# Warm only specific styles (comma-separated machine names):
drush image:derive:multiple --image-styles=large,thumbnail

# Short alias:
drush idm --skip-existing
```

Notes:

- The command aliases are `idm` and `image_derivatives:generate`.
- Without `--skip-existing` it regenerates every derivative unconditionally
  (overwriting existing files) — handy after you change an image style's effects
  or after partially clearing the derivative directory.
- With `--skip-existing` it only builds what is missing, so it is safe to drop
  into a deploy hook.
- `--image-styles` filters by style; there is no option to limit it to specific
  files — it always scans every published image.
- The style names are the machine names of your image styles (see
  **Configuration → Media → Image styles**, `/admin/config/media/image-styles`).

Typical times to run it: before a launch, in CI/CD before visual-regression
tests, after `drush image:flush`, after adding or editing an image style, or
after copying production images into a fresh environment.
