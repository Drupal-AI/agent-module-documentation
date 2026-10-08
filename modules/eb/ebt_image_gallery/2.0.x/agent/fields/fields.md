<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fields & config on the ebt_image_gallery block type

Bundle: `block_content` / `ebt_image_gallery` (installed via `config/install`).

## Fields
- **`field_ebt_image_gallery`** — the gallery images.
  - Storage: `entity_reference`, `target_type: media`, **cardinality `-1`** (unlimited), translatable.
  - Instance: **required**, `target_bundles: {image: image}`, handler `default:media`.
  - Form widget: `media_library_widget`. View formatter: `entity_reference_entity_view`.
- **`field_ebt_settings`** — shared EBT settings (`ebt_settings` field type from ebt_core).
  - Form widget: **`ebt_settings_image_gallery`** (this module). View formatter: `ebt_settings_default`.
  - Holds the **Styles** choice and the Design options tree
    (`ebt_settings.design_options.*`).
- **`body`** — standard text field; hidden on the default form display.

## Displays
- **Form display** (`…entity_form_display.block_content.ebt_image_gallery.default`): field_group
  tabs — *Content* (info, body, field_ebt_image_gallery, langcode) and *Settings*
  (field_ebt_settings). Requires `field_group`, `media_library`, `text`.
- **View display** (`…entity_view_display.block_content.ebt_image_gallery.default`): body,
  field_ebt_image_gallery (`entity_reference_entity_view`), field_ebt_settings
  (`ebt_settings_default`).

## Media-side config (shipped)
- **`image.style.ebt_gallery_image`** — image style `image_scale_and_crop` 365×265, center anchor.
- **`core.entity_view_mode.media.ebt_image_gallery`** — a media view mode.
- **`core.entity_view_display.media.image.ebt_image_gallery`** — renders `field_media_image` with
  the **`glightbox`** formatter: node style `ebt_gallery_image`, `glightbox_gallery: parent`,
  `glightbox_caption: auto` (caption drawn from media alt/name), image label visually hidden.

## Templates
- `block--block-content--ebt-image-gallery.html.twig` and
  `block--inline-block--ebt-image-gallery.html.twig` — wrapper markup; append the selected
  `styles` class to the block; end with `{{ styles|raw }}` (inline `<style>` from ebt_core).
- `field--block-content--field-ebt-image-gallery--ebt-image-gallery.html.twig` — the field wrapper
  (`ebt-image-gallery-wrapper`) the grid CSS targets.

## Widget specifics (`EbtSettingsImageGalleryWidget`)
- Extends ebt_core `EbtSettingsDefaultWidget`; calls `parent::formElement()` then adds the
  **Styles** radios and sets `pass_options_to_javascript` hidden = FALSE (no drupalSettings JS
  payload for this block).
- `massageFormValues()` ensures each delta has an `ebt_settings` key.
