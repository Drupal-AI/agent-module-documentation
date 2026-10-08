<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph type `ept_image` and its fields

Defined entirely as installed config under `config/install/`. Enabling the module creates the
Paragraphs bundle `ept_image` (`paragraphs.paragraphs_type.ept_image`, label "EPT Image") plus the
fields below and their default form/view displays.

## Fields (bundle `ept_image`, entity type `paragraph`)

| Field name | Type | Storage / settings | Required | Notes |
|---|---|---|---|---|
| `field_ept_title` | `text_long` | shared storage (from ept_core) | no | Section heading; rendered in an `<h2>` by the template. |
| `field_ept_text` | `text_long` | shared storage (from ept_core) | no | Optional body text. |
| `field_ept_image` | `entity_reference` → `media` | cardinality 1, `target_bundles: {image: image}`, handler `default:media`, `auto_create: false` | **yes** | The image. Only the `image` media bundle is selectable. |
| `field_ept_image_caption` | `text_long` | `module: text` | no | Caption; also used as GLightbox slide title. |
| `field_ept_image_link` | `link` | `module: link`, `title: 0` (no title), `link_type: 17` (LINK_GENERIC — internal + external) | no | Wraps the image in an `<a href>`. |
| `field_ept_settings` | `ept_settings` | provided by `ept_core` | no | Per-paragraph design + image display options (see settings-widget.md). |

`field.storage.paragraph.field_ept_image`, `…_caption`, `…_link` ship here; the `field_ept_title`,
`field_ept_text` and `field_ept_settings` storages are provided by `ept_core`.

## Default form display (`core.entity_form_display.paragraph.ept_image.default`)

`field_group` (module dep) arranges the edit form into horizontal **Tabs**:

- **Content** tab (`group_content`, open): `field_ept_title`, `field_ept_text`, `field_ept_image`,
  `field_ept_image_caption`, `field_ept_image_link`.
- **Settings** tab (`group_settings`, closed): `field_ept_settings`.

Widgets: `field_ept_image` → **`media_library_widget`** (media_library dep); `field_ept_settings`
→ **`ept_settings_image`** (this module's widget); `field_ept_image_link` → `link_default`;
title/text/caption → `text_textarea` (5 rows). `created` and `status` are hidden.

## Default view display (`core.entity_view_display.paragraph.ept_image.default`)

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_title` | `text_default` | label hidden |
| `field_ept_text` | `text_default` | label hidden |
| `field_ept_settings` | `ept_settings_default` (ept_core) | emits the design `<style>` block + attaches JS |
| `field_ept_image_link` | `link` | label hidden |
| `field_ept_image` | **`media_thumbnail`** | `image_loading.attribute: lazy`; image_style overridden at runtime (see theme/rendering.md) |
| `field_ept_image_caption` | `text_default` | label hidden |

## Setting the bundle up via drush/PHP

The bundle and fields are created automatically on install (`drush en ept_image`). To reuse the
paragraph in content, add a Paragraphs (or Entity Reference Revisions) field to a node type and allow
the `ept_image` bundle — no module-specific API is involved.

Config-schema note: this module ships **no** `config/schema/*` of its own; the `ept_settings` field
type's schema comes from `ept_core`.
