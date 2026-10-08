<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Rotate Lite (auto_rotate_lite) — agent index

An image-style effect that auto-rotates JPEG/TIFF derivatives from their EXIF `Orientation` flag. Non-destructive: only the style derivative is rotated, never the original upload. Core + GD + PHP `exif` extension only.

## Facts
- Core: `^10 || ^11`. Package `Custom`. License GPL-2.0-or-later.
- Dependency: Drupal core `image` module (provides the ImageEffect plugin type). No contrib deps; `composer.json` `require` is empty.
- No routes, no permissions, no services, no hooks, no config schema, no settings form, no submodules, no Drush commands.
- Requires PHP's `exif` extension (`exif_read_data()`); degrades silently if absent.

## What it provides
- One image effect plugin: `AutoRotateLiteImageEffect` (id `auto_rotate_lite`), extends `ImageEffectBase`. Registered via the `#[ImageEffect]` attribute.

## Solution docs
- [Plugin: auto-rotate image effect](plugins/auto_rotate_effect.md) — how the effect works, install/enable, adding it to an image style, and its EXIF/rotation/dimension logic.
