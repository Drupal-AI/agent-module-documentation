# SVG Image Widget Crop — manual setup guide

**SVG Image Widget Crop** (`svg_image_widget_crop`) is a small compatibility shim
that makes the [Image Widget Crop](https://www.drupal.org/project/image_widget_crop)
widget **skip SVG files**. Vector images have no fixed pixel dimensions, so there
is nothing to crop — and trying to show a crop UI for them produces a broken,
empty widget and JavaScript errors. This module quietly bypasses cropping for
SVGs while leaving raster images (PNG, JPG) cropping normally.

The problem it solves shows up when a single image field accepts both vector and
raster media and is configured with Image Widget Crop. Without this module,
editors who upload an SVG logo or icon hit a confusing, non‑functional crop
interface. With it, SVG uploads simply save without the crop step, so you can mix
SVG and photographic images in the same crop‑enabled field.

It works entirely on‑enable — there is **nothing to configure**. Under the hood
it ships a single form element that extends Image Widget Crop's `image_crop`
element and returns early when the uploaded file's MIME type is an SVG (and the
`svg_image` module is present). It has no routes, permissions, services, or
settings, and it stores no config or state, so it uninstalls cleanly. It depends
on **Image Widget Crop** (`image_widget_crop`) and **SVG Image** (`svg_image`),
and supports Drupal 8.8 through 11.

A note on security: this module does **not** render or sanitise SVGs — it only
skips the crop UI for them. Displaying SVGs safely (and any sanitisation) is the
job of the `svg_image` dependency, so this shim adds no XSS surface of its own.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, then enable them.

## How to use it

There is no admin page and no settings. Once the module is enabled alongside
Image Widget Crop and SVG Image, the behaviour is automatic: when an editor
uploads an SVG to a crop‑enabled image field, the crop step is skipped based on
the file's `image/svg` MIME type; raster images continue to crop as before.
