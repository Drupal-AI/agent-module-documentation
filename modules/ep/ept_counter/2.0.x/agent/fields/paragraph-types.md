<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ept_counter — paragraph bundles & fields

Two Paragraphs bundles are created from `config/install/` on module install. Enable with
`drush en ept_counter` (pulls in `ept_core`, `paragraphs`). Add the "EPT Counter" paragraph to any
entity that has a Paragraphs (entity_reference_revisions) field.

## Bundle `ept_counter` (container)
Defined in `paragraphs.paragraphs_type.ept_counter.yml`. Fields (with view display
`core.entity_view_display.paragraph.ept_counter.default.yml`):

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_title` | text_long | Block heading; wrapper tag chosen in EPT settings. Formatter `text_default`. |
| `field_ept_text` | text_long | WYSIWYG intro text. Formatter `text_default`. |
| `field_ept_settings` | ept_settings (ept_core) | Widget `ept_settings_counter`; formatter `ept_settings_default`. Holds layout + CountUp options. |
| `field_ept_counter_items` | entity_reference_revisions | References `ept_counter_item` paragraphs; formatter `entity_reference_revisions_entity_view`. |

## Bundle `ept_counter_item`
Defined in `paragraphs.paragraphs_type.ept_counter_item.yml`. One row = one animated number.

| Field | Type | Storage / settings |
|-------|------|--------------------|
| `field_ept_counter_number` | integer | Storage `field.storage.paragraph.field_ept_counter_number.yml` (cardinality 1). Field required, `min: 1`. View formatter `number_integer` with `thousand_separator: ''`. This integer is the CountUp end value. |
| `field_ept_counter_title` | text_long | Required. Formatter `text_default`. |
| `field_ept_counter_description` | text_long | Optional. Formatter `text_default`. |
| `field_ept_counter_icon` | entity_reference → media | Handler `default:media`, `target_bundles: image` — needs a Media `image` type. Formatter `entity_reference_entity_view`. |

## Templating
- `templates/paragraph--ept-counter--default.html.twig` — wraps items in `.ept-paragraph-counter`,
  adds `ept-counter-<styles>` layout class (styles = `two_columns`/`three_columns`/`four_columns`),
  renders the title inside a configurable wrapper (`h1`–`h5`, default `h2`), attaches
  `ept_counter/countup`, and sets the container id to `paragraph-id-<id>`.
- `templates/field--paragraph--ept-counter--field-ept-counter-number.html.twig` — renders each
  number into `<div class="ept-counter-number" id="ept-counter-number-<paragraph-item-id>">`; the JS
  reads its `textContent` as the animation target.
- `templates/paragraph--ept-counter-item--default.html.twig` — wraps an item's fields in
  `.ept-counter-content`.

The theme hooks / registry entries for these templates are registered by
`EptCounterHooks::theme()`, `EptCounterHooks::themeRegistryAlter()`, and the procedural
`ept_counter_theme_suggestions_field_alter()` in `ept_counter.module`.
