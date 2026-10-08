<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Image Media Attributes Formatter (advanced_image_media_attributes_formatter) — agent index

Adds native image performance attributes — **fetchpriority**, **decoding**, and (for media) a
**loading** override — to Drupal's existing **Image** and **Rendered entity** field formatters.
Package `Custom`. Depends on core **`image`** and **`media`**. Core requirement `^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.1.

- **Both formatter classes, every setting, how the attributes are attached, and how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- It ships **no new formatter plugin id**. `advanced_image_media_attributes_formatter.module` implements
  `hook_field_formatter_info_alter()` and rewrites the `class` of two core formatters:
  - `image` → `ImageFieldWithAttributesFormatter`
  - `entity_reference_entity_view` → `MediaWithAttributesFormatter`
  So the extra options appear inside the **existing** "Image" and "Rendered entity" formatter settings.
- No routes, no permissions, no services, no config schema, no Drush. `hook_install()` only sets the
  module weight to 100 so its alter runs after other image modules.

## Provided classes (from source)

- `src/Plugin/Field/FieldFormatter/ImageFieldWithAttributesFormatter.php` — extends core
  `ImageFormatter`; adds `fetchpriority` and `decoding` select settings; a `TrustedCallbackInterface`.
- `src/Plugin/Field/FieldFormatter/MediaWithAttributesFormatter.php` — extends
  `RenderedMediaWithImageStyleFormatter` (from the optional `media_image_style_formatter` module) if
  present, otherwise core `EntityReferenceEntityFormatter`, chosen at load time via a dynamic
  `MediaWithAttributesFormatterBase` class alias. Adds `override_image_loading`, `image_field_name`,
  `image_loading_attribute`, `fetchpriority`, `decoding` settings.

## Mechanism (from source)

- Each formatter's `viewElements()` calls `parent::viewElements()`, then attaches a static
  `preRenderAddAttributes` pre-render callback (registered in `trustedCallbacks()`).
- The callback sets values into the image render array's `#attributes` (themes `image`, `image_style`)
  or `#item_attributes` (theme `image_formatter`), so Drupal's Attribute rendering emits them; media
  handling drills into the configured `image_field_name` sub-element and also a nested `[0]` structure.
- All option values come from **fixed select/radio option lists** (fetchpriority: high/low/auto;
  decoding: async/sync/auto; loading: lazy/eager); `image_field_name` is chosen from the media
  bundles' actual image fields. There is no free-text attribute name/value input.

## Settings summary

- Image formatter: `fetchpriority` (''), `decoding` ('') on top of core image settings.
- Media formatter: `override_image_loading` (FALSE), `image_field_name` ('field_media_image'),
  `image_loading_attribute` ('lazy'), `fetchpriority` (''), `decoding` (''). Details in
  [fields/formatter.md](fields/formatter.md).

## Notes / caveats

- Because it alters core formatters **globally**, the added settings appear on every Image field and
  every entity-reference "Rendered entity" formatter site-wide.
- No config schema ships for the added keys, so strict config-schema tooling may flag the view-display
  config; the settings still save and work.
