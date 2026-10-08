<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Video (drowl_paragraphs_bs_type_video) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `video` Paragraph type.

- **Field**: `field_video` (entity reference → `media`, target bundles `video` + `remote_video`, required,
  auto_create_bundle `remote_video`). Shared `field_settings` (hidden).
- Displayed with core **`entity_reference_entity_view`** (`view_mode: default`) — the referenced media
  entity is rendered by its own display (oEmbed for remote video, file for uploads); media access applies.
- Depends on core `media`. No routes/permissions/services/schema of its own. No template or `.module`.

See [paragraphs/video.md](paragraphs/video.md).
