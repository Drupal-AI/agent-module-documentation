<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph types `ept_carousel` / `ept_carousel_item` and their fields

Everything here is defined as installed config under `config/install/`. Enabling the module creates
**two** Paragraphs bundles and their fields, storages, and default form/view displays. There is no
PHP that builds them, and this module ships **no config schema** of its own (the `ept_settings`
field type's schema comes from `ept_core`).

## Bundle `ept_carousel` (the wrapper)

`paragraphs.paragraphs_type.ept_carousel` — label **"EPT Carousel"**, description "Extra Paragraph
Type (EPT): Carousel". This is the paragraph an editor adds to content.

| Field name | Type | Storage / settings | Notes |
|---|---|---|---|
| `field_ept_title` | `text_long` | shared storage from ept_core (`field.storage.paragraph.field_ept_title`) | Optional section heading; rendered in a title wrapper by the template. Label "Title". |
| `field_ept_text` | `text_long` | shared storage from ept_core | Optional intro/body text. Label "Text". |
| `field_ept_carousel` | `entity_reference_revisions` → `paragraph` | ships here; **cardinality -1** (unlimited), `target_bundles: {ept_carousel_item}`, handler `default:paragraph` | The ordered list of slides. Label "Carousel". |
| `field_ept_settings` | `ept_settings` | provided by ept_core | Per-paragraph Tiny Slider options + EPT design options (see [../configure/settings.md](../configure/settings.md)). Label "Settings". |

## Bundle `ept_carousel_item` (one slide)

`paragraphs.paragraphs_type.ept_carousel_item` — label **"EPT Carousel Item"**, description
"Carousel item for EPT Carousel". Referenced only from `field_ept_carousel`; it is not meant to be
added directly to content.

| Field name | Type | Storage / settings | Notes |
|---|---|---|---|
| `field_ept_carousel_image` | `entity_reference` → `media` | ships here; **cardinality 1**, **required: true**, `target_bundles: {image: image}`, handler `default:media`, `auto_create: false` | The slide image. Only the `image` media bundle is selectable. Label "Slide image". |
| `field_ept_carousel_caption` | `text_long` | ships here (cardinality 1) | Slide caption/body. Label "Slide caption". |
| `field_ept_carousel_item_link` | `link` | ships here; `title: 0` (no link title), **`link_type: 17`** (LINK_GENERIC — internal + external) | Optional link. Label "Slide Link", description "Use this link to wrap the slide." The item template is *supposed* to wrap the slide image in this link — see the template note in [../theme/rendering.md](../theme/rendering.md). |

The `field_ept_carousel_image` field is marked required in the shipped config, and
`ept_carousel_update_9102()` re-asserts that on existing sites.

## Form displays

`core.entity_form_display.paragraph.ept_carousel.default` uses **field_group** to split the edit
form into horizontal **Tabs**:

- **Content** tab (`group_content`, open): `field_ept_title`, `field_ept_text`, `field_ept_carousel`.
- **Settings** tab (`group_settings`, closed): `field_ept_settings`.

Widgets: `field_ept_settings` → **`ept_settings_carousel`** (this module's widget);
`field_ept_carousel` → **`paragraphs`** (nested paragraphs UI, `add_mode: dropdown`,
`edit_mode: open`, features `collapse_edit_all` + `duplicate`); `field_ept_title` → `text_textarea`
(2 rows); `field_ept_text` → `text_textarea` (5 rows). `created` and `status` are hidden.

`core.entity_form_display.paragraph.ept_carousel_item.default`: `field_ept_carousel_image` →
**`media_library_widget`**; `field_ept_carousel_caption` → `text_textarea` (5 rows);
`field_ept_carousel_item_link` → `link_default`. `created`/`status` hidden.

## View displays

`core.entity_view_display.paragraph.ept_carousel.default`:

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_title` | `text_default` | label hidden |
| `field_ept_text` | `text_default` | label hidden |
| `field_ept_settings` | `ept_settings_default` (ept_core) | emits the design `<style>` block + attaches the JS options (see [../theme/rendering.md](../theme/rendering.md)) |
| `field_ept_carousel` | `entity_reference_revisions_entity_view` | `view_mode: default` — renders each slide item |

`core.entity_view_display.paragraph.ept_carousel_item.default`:

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_carousel_image` | `media_thumbnail` | `image_loading.attribute: lazy`, `image_style: ''` (the effective style is overridden per-render by the wrapper's `image_size` setting — see rendering doc) |
| `field_ept_carousel_caption` | `text_default` | label hidden |
| `field_ept_carousel_item_link` | `link` | label hidden, `trim_length: 1024` |

## Reusing the bundle

The bundles and fields are created automatically on install (`drush en ept_carousel`, once an
`image` media type exists). To use the carousel in content, add a Paragraphs (or Entity Reference
Revisions) field to a node type and allow the `ept_carousel` bundle — no module-specific API is
involved.
