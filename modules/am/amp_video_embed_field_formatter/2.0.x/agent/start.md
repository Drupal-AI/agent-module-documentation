<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# amp_video_embed_field_formatter

Bridge that gives Video Embed Field an AMP-valid formatter.

- Plugin: `src/Plugin/Field/FieldFormatter/AmpVideoEmbedFormatter.php`; Twig in `templates/`.
- Hard deps: `amp`, `video_embed_field`, core `field`+`image`.
- Display-layer only: no routes/permissions/services. Assign on a video_embed_field field's Manage Display for AMP view modes.

See [../usage.md](../usage.md).
