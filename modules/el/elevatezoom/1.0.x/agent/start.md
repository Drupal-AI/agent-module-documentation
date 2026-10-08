<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elevate Image Zoom (elevatezoom) — agent index

An image **field formatter** that renders `image` fields with the jQuery **ElevateZoom Plus**
magnify/zoom effect, plus a multi-image thumbnail gallery and a Fancybox-Plus lightbox mode.
Package `Media`. Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.6.

Distinct project from the similarly named `elevate_image_zoom`; this one is `elevatezoom`
(machine name), whose formatter plugin id is `elevatezoom_formatter`.

## What it actually is (from source)

- One plugin: `ImageElevateZoomFormatter` (id **`elevatezoom_formatter`**, label *"Elevate Image
  Zoom"*) in `src/Plugin/Field/FieldFormatter/ImageElevateZoomFormatter.php`, extending core
  **`image` module's** `ImageFormatter`; `field_types = { "image" }`. Because it extends
  `ImageFormatter`, the core **`image`** module is a de-facto dependency (not declared in
  `elevatezoom.info.yml`).
- `elevatezoom.module` implements **`hook_theme()`** (`elevate_image_zoom_template` →
  `templates/elevate-image-zoom-template.html.twig`) and **`hook_help()`**.
- Three JS/CSS libraries in `elevatezoom.libraries.yml`; behaviour in `js/elevate_script.js`
  (`Drupal.behaviors.elevatezoom`).
- **No** routes, permissions, services, install file, config entities, or config schema. All
  settings live in the field's **view-display** config (`defaultSettings()`).

## Solution docs

- **The formatter — settings, `viewElements()`, the twig template, zoom types, how to enable** →
  [fields/formatter.md](fields/formatter.md)
- **The three libraries, CDN vs local switch, external library install, JS behaviour** →
  [setup/libraries.md](setup/libraries.md)

## Enable

```bash
composer require drupal/elevatezoom
drush en elevatezoom -y   # core image module must also be enabled
```

Then on *Manage display* set an image field's format to **Elevate Image Zoom** and configure it.
