<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph types `ept_timeline` / `ept_timeline_item` and their fields

Everything here is defined as installed config under `config/install/`. Enabling the module creates
**two** Paragraphs bundles and their fields, storages, and default form/view displays. There is no
PHP that builds them and no config schema shipped by this module (the `ept_settings` field type's
schema comes from `ept_core`).

## Bundle `ept_timeline` (the wrapper)

`paragraphs.paragraphs_type.ept_timeline` — label **"EPT Timeline"**. This is the paragraph an editor
adds to content.

| Field name | Type | Storage / settings | Notes |
|---|---|---|---|
| `field_ept_title` | `text_long` | shared storage from ept_core (`field.storage.paragraph.field_ept_title`) | Optional heading; rendered in an `<h2>` by the wrapper template. |
| `field_ept_text` | `text_long` | shared storage from ept_core | Optional intro/body text. |
| `field_ept_timeline` | `entity_reference_revisions` → `paragraph` | ships here; **cardinality -1** (unlimited), **`required: true`**, `target_bundles: {ept_timeline_item}`, handler `default:paragraph` | The ordered list of timeline events. |
| `field_ept_settings` | `ept_settings` | provided by ept_core | Per-paragraph EPT design options + the `styles` selector (see [../configure/settings.md](../configure/settings.md)). |

## Bundle `ept_timeline_item` (one event)

`paragraphs.paragraphs_type.ept_timeline_item` — label **"EPT Timeline Event"**, description
"Timeline section for EPT Timeline". Referenced only from `field_ept_timeline`; it is not meant to be
added directly to content.

| Field name | Type | Storage / settings | Notes |
|---|---|---|---|
| `field_ept_timeline_date` | `string` | ships here (cardinality 1) | Free-text date/label shown in the `.timeline-date` badge. Plain string, not a date field — any text is accepted. |
| `field_ept_timeline_title` | `string` | ships here (cardinality 1) | Event title (`<h3>`). |
| `field_ept_timeline_text` | `text_long` | ships here | Event body (`.timeline-text`). |
| `field_ept_timeline_current` | `boolean` | ships here; `on_label: 'On'`, `off_label: 'Off'` | When "On", the item template adds the `timeline-current` class (highlighted marker dot). |
| `field_ept_timeline_media_image` | `entity_reference` → `media` | ships here; **cardinality 1**, `target_bundles: {image: image}`, handler `default:media`, `auto_create: false` | Optional event image. Only the `image` media bundle is selectable. Its file URL becomes the `.timeline-img-header` background (via the module's preprocess — see [../theme/rendering.md](../theme/rendering.md)). |

Note the two title/text field families differ per bundle: the wrapper uses the shared ept_core
`field_ept_title` / `field_ept_text`; each event uses its own `field_ept_timeline_title` /
`field_ept_timeline_text`.

## Form displays

`core.entity_form_display.paragraph.ept_timeline.default` uses **field_group** to split the edit form
into horizontal **Tabs**:

- **Content** tab (`group_content`, open): `field_ept_title`, `field_ept_text`, `field_ept_timeline`.
- **Settings** tab (`group_settings`, closed): `field_ept_settings`.

Widgets: `field_ept_settings` → **`ept_settings_timeline`** (this module's widget); `field_ept_timeline`
→ **`paragraphs`** (nested paragraphs UI, `add_mode: dropdown`, `edit_mode: open`, features
`collapse_edit_all` + `duplicate`); title/text → `text_textarea` (5 rows). `created` and `status` are
hidden.

`core.entity_form_display.paragraph.ept_timeline_item.default`: `field_ept_timeline_media_image` →
**`media_library_widget`**; `field_ept_timeline_current` → `boolean_checkbox`;
`field_ept_timeline_date` / `field_ept_timeline_title` → `string_textfield` (size 60);
`field_ept_timeline_text` → `text_textarea` (5 rows). `created`/`status` hidden.

## View displays

`core.entity_view_display.paragraph.ept_timeline.default`:

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_title` | `text_default` | label hidden |
| `field_ept_text` | `text_default` | label hidden |
| `field_ept_settings` | `ept_settings_default` (ept_core) | emits the design `<style>` block + attaches JS options (see [../theme/rendering.md](../theme/rendering.md)) |
| `field_ept_timeline` | `entity_reference_revisions_entity_view` | `view_mode: default`, `label: visually_hidden` — renders each event item |

`core.entity_view_display.paragraph.ept_timeline_item.default`:

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_timeline_date` | `string` | label hidden, `link_to_entity: false` |
| `field_ept_timeline_title` | `string` | label hidden, `link_to_entity: false` |
| `field_ept_timeline_text` | `text_default` | label hidden |
| `field_ept_timeline_current` | `boolean` | label hidden, `format: default` (renders `On`/`Off` — the template reads this markup) |
| `field_ept_timeline_media_image` | `entity_reference_entity_view` | `view_mode: default`, `label: above`, `link: false` — but the item template suppresses this field and instead uses the file URL as a CSS background |

## Reusing the bundle

The bundles and fields are created automatically on install (`drush en ept_timeline`, once `ept_core`
and an `image` media type exist). To use the timeline in content, add a Paragraphs (or Entity
Reference Revisions) field to a node type and allow the `ept_timeline` bundle — no module-specific API
is involved.
