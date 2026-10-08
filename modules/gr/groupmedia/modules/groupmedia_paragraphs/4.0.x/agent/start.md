<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Media Paragraphs tracker — agent index

Submodule of **Group Media**. Adds two `media_finder` plugins so the parent's automatic
media tracking finds media **inside Paragraphs**. Requires `groupmedia` + `paragraphs`.
No config, permissions, routes, or services of its own.

- **The two finder plugins it adds and how they descend into Paragraphs** →
  [plugins/paragraphs-finders.md](plugins/paragraphs-finders.md)

Key facts:
- `paragraphs_media_reference` — field type `entity_reference_revisions`; finds media in
  entity-reference fields on Paragraphs (extends `MediaFinderBase`).
- `paragraphs_media_embed` — text field types (`text`, `text_long`, `text_with_summary`),
  element `drupal-media`; finds *Embed media* media inside Paragraph text (extends the
  parent's `EntityEmbed` finder).
- Both use `ParagraphsMediaFinderTrait::getParagraphs()`, which recurses into nested Paragraphs.
- Provider `groupmedia_paragraphs`; only acts when the parent Group Media relation for the
  media type has `tracking_enabled` on. See the parent's
  [media_finder plugin type](../../../../4.0.x/agent/plugins/media-finder.md).
