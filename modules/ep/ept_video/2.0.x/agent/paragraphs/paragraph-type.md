<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph type `ept_video` and its fields

Defined entirely as installed config under `config/install/`. Enabling the module creates the
Paragraphs bundle `ept_video` (`paragraphs.paragraphs_type.ept_video`, label "EPT Video",
description "Extra Paragraph Type (EPT): Video") plus the fields below and their default form/view
displays. There is no `.install` schema beyond a `hook_requirements()` gate (see below) and no
module-specific API.

## Install requirement

`ept_video_requirements($phase)` (`ept_video.install`) runs at the **install** phase only. It scans
`MediaType::loadMultiple()` for an id `remote_video`; if none exists it returns a
`RequirementSeverity::Error` (`REQUIREMENT_ERROR` on older core) blocking install, with a link to
`/admin/structure/media`. So the `remote_video` media type (source `oembed:video`) must exist first.
On this site it is already scaffolded.

## Fields (bundle `ept_video`, entity type `paragraph`)

| Field name | Type | Storage / settings | Required | Notes |
|---|---|---|---|---|
| `field_ept_video` | `entity_reference` → `media` | storage ships here (`field.storage.paragraph.field_ept_video`, `target_type: media`, cardinality 1); field `target_bundles: {remote_video: remote_video}`, handler `default:media`, `auto_create: false` | **yes** | The video. Only the core **`remote_video`** (oEmbed) media bundle is selectable out of the box. Local video would require adding/wiring your own `video_file` media type. |
| `field_ept_title` | `text_long` | shared storage from ept_core (`field.storage.paragraph.field_ept_title`) | no | Section heading; rendered in an `<h2>` by the template. |
| `field_ept_text` | `text_long` | shared storage from ept_core (`field.storage.paragraph.field_ept_text`) | no | Optional body text below the video. |
| `field_ept_settings` | `ept_settings` | field type + storage from ept_core | no | Per-paragraph EPT design options (see settings-widget.md). |

This module ships **only** the `field_ept_video` storage; the `field_ept_title`, `field_ept_text`
and `field_ept_settings` storages come from `ept_core`.

## Default form display (`core.entity_form_display.paragraph.ept_video.default`)

`field_group` (module dep) arranges the edit form into horizontal **Tabs** (`group_tabs`):

- **Content** tab (`group_content`, open): `field_ept_title`, `field_ept_video`, `field_ept_text`.
- **Settings** tab (`group_settings`, closed): `field_ept_settings`.

Widgets: `field_ept_video` → **`media_library_widget`** (media_library dep); `field_ept_settings`
→ **`ept_settings_video`** (this module's widget); `field_ept_title` / `field_ept_text` →
`text_textarea` (2 / 5 rows). `created` and `status` are hidden.

## Default view display (`core.entity_view_display.paragraph.ept_video.default`)

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_title` | `text_default` | label hidden, weight 0 |
| `field_ept_text` | `text_default` | label hidden, weight 1 |
| `field_ept_video` | **`entity_reference_entity_view`** | `view_mode: ept_video`, `link: false` — renders the referenced media in the `ept_video` media view mode |
| `field_ept_settings` | `ept_settings_default` (ept_core) | emits the design `<style>` block + attaches JS/library (via ept_core's `hook_preprocess_paragraph`) |

## Media view mode & display (how the video actually renders)

- `core.entity_view_mode.media.ept_video` — a Media view mode "EPT Video" (`media.ept_video`).
- `core.entity_view_display.media.remote_video.ept_video` — display for `remote_video` media in that
  view mode. It renders **`field_media_oembed_video`** (core Media's oEmbed field on the
  `remote_video` bundle) with the **`glightbox_media_remote_video`** formatter
  (from `glightbox_media_video`), settings: `display: thumbnail`, `link_text: 'View Video'`,
  `loading.attribute: eager`, `glightbox_gallery: post`, `glightbox_caption: auto`. `name`,
  `thumbnail`, `uid`, `created` hidden.

Net effect: the paragraph shows the video's thumbnail; clicking opens the oEmbed player in a
GLightbox overlay. The video URL is stored on the core oEmbed field and resolved by **core Media**
against its provider allowlist — this module contributes no raw-URL handling.

## Setting the bundle up via drush/PHP

The bundle and fields are created automatically on install (`drush en ept_video`). To reuse the
paragraph in content, add a Paragraphs (or Entity Reference Revisions) field to a node type and allow
the `ept_video` bundle — no module-specific API is involved.

Config-schema note: this module ships **no** `config/schema/*`; the `ept_settings` field type's
schema comes from `ept_core`.
