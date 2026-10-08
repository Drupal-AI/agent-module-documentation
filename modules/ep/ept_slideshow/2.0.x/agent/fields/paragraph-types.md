<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph types `ept_slideshow` / `ept_slideshow_item` and their fields

Everything here is defined as installed config under `config/install/`. Enabling the module creates
**two** Paragraphs bundles and their fields, storages, and default form/view displays. There is no
PHP that builds them and no config schema shipped by this module (the `ept_settings` field type's
schema comes from `ept_core`).

## Bundle `ept_slideshow` (the wrapper)

`paragraphs.paragraphs_type.ept_slideshow` — label **"EPT Slideshow"**. This is the paragraph an
editor adds to content.

| Field name | Type | Storage / settings | Notes |
|---|---|---|---|
| `field_ept_title` | `text_long` | shared storage from ept_core (`field.storage.paragraph.field_ept_title`) | Optional section heading; rendered in a title wrapper by the template. |
| `field_ept_text` | `text_long` | shared storage from ept_core | Optional intro/body text. |
| `field_ept_slideshow` | `entity_reference_revisions` → `paragraph` | ships here; **cardinality -1** (unlimited), `target_bundles: {ept_slideshow_item}`, handler `default:paragraph` | The ordered list of slides. |
| `field_ept_settings` | `ept_settings` | provided by ept_core | Per-paragraph Flexslider options + EPT design options (see [../configure/settings.md](../configure/settings.md)). |

## Bundle `ept_slideshow_item` (one slide)

`paragraphs.paragraphs_type.ept_slideshow_item` — label **"EPT Slideshow Item"**, description
"Slideshow section for EPT Slideshow". Referenced only from `field_ept_slideshow`; it is not meant
to be added directly to content.

| Field name | Type | Storage / settings | Notes |
|---|---|---|---|
| `field_ept_slideshow_slide` | `entity_reference` → `media` | ships here; **cardinality 1**, `target_bundles: {image: image}`, handler `default:media`, `auto_create: false` | The slide image. Only the `image` media bundle is selectable. |
| `field_ept_slideshow_title` | `text_long` | ships here (cardinality 1) | Slide title. |
| `field_ept_slideshow_text` | `text_long` | ships here | Slide caption/body. |
| `field_ept_slideshow_link` | `link` | ships here; `title: 1`, **`link_type: 17`** (LINK_GENERIC — internal + external) | Optional link; the item template wraps the slide image in `<a href>` when set. |

Note the two title/text field families differ per bundle: the wrapper uses the shared ept_core
`field_ept_title` / `field_ept_text`; each slide uses its own `field_ept_slideshow_title` /
`field_ept_slideshow_text`.

## Form displays

`core.entity_form_display.paragraph.ept_slideshow.default` uses **field_group** to split the edit
form into horizontal **Tabs**:

- **Content** tab (`group_content`, open): `field_ept_title`, `field_ept_text`,
  `field_ept_slideshow`.
- **Settings** tab (`group_settings`, closed): `field_ept_settings`.

Widgets: `field_ept_settings` → **`ept_settings_slideshow`** (this module's widget);
`field_ept_slideshow` → **`paragraphs`** (nested paragraphs UI, `add_mode: dropdown`,
`edit_mode: open`, features `collapse_edit_all` + `duplicate`); title/text → `text_textarea`
(5 rows). `created` and `status` are hidden.

`core.entity_form_display.paragraph.ept_slideshow_item.default`: `field_ept_slideshow_slide` →
**`media_library_widget`**; `field_ept_slideshow_link` → `link_default`; title/text →
`text_textarea` (5 rows). `created`/`status` hidden.

## View displays

`core.entity_view_display.paragraph.ept_slideshow.default`:

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_title` | `text_default` | label hidden |
| `field_ept_text` | `text_default` | label hidden |
| `field_ept_settings` | `ept_settings_default` (ept_core) | emits the design `<style>` block + attaches the JS options (see [../theme/rendering.md](../theme/rendering.md)) |
| `field_ept_slideshow` | `entity_reference_revisions_entity_view` | `view_mode: default` — renders each slide item |

`core.entity_view_display.paragraph.ept_slideshow_item.default`:

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_slideshow_slide` | `media_thumbnail` | `image_loading.attribute: lazy`, `image_style: ''` |
| `field_ept_slideshow_title` | `text_default` | label hidden |
| `field_ept_slideshow_text` | `text_default` | label hidden |
| `field_ept_slideshow_link` | `link` | label hidden, `trim_length: 800` |

## Reusing the bundle

The bundles and fields are created automatically on install (`drush en ept_slideshow`). To use the
slideshow in content, add a Paragraphs (or Entity Reference Revisions) field to a node type and allow
the `ept_slideshow` bundle — no module-specific API is involved.
