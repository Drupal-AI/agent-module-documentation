<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `video` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_video -y`.

## What it installs (config/install)
- `paragraphs.paragraphs_type.video` — the bundle.
- `field.storage.paragraph.field_video` (entity reference, target_type `media`) +
  `field.field.paragraph.video.field_video` (required, label 'Video', target bundles `video` and
  `remote_video`, `auto_create_bundle: remote_video`).
- `field_settings` — shared settings field.
- View display: `field_video` rendered by core **`entity_reference_entity_view`** (`view_mode: default`,
  label hidden, fences); settings + preview placeholder hidden; Layout Builder disabled.

## Rendering
The referenced media entity is rendered by the standard entity view builder, so all video output
(remote oEmbed iframe for `remote_video`, file player for uploaded `video`) and escaping come from the
media type's display configuration and core/media handling. This sub-module ships no template of its own.
