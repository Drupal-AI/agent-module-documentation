<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Entity Embed — agent index

Embeds Paragraph entities inline in CKEditor 5 rich text via a "Paragraphs" button; each embed is
an `embedded_paragraphs` entity referenced by a `<drupal-paragraph>` tag, expanded by a filter on
render. Built on `ckeditor5`, `embed`, `entity_embed`, `paragraphs`. No single settings page
(`configure: null`) — config is per text format + the embed button.

- **Turn it on for a text format (filter + toolbar button); the embed button & view mode** →
  [configure/setup.md](configure/setup.md)
- **The `embedded_paragraphs` content entity (fields, storage, permissions)** →
  [api/embedded-paragraphs.md](api/embedded-paragraphs.md)
- **The plugin surface: filter, CKEditor 5 plugin, embed type, embed display, widget** →
  [plugins/integration.md](plugins/integration.md)

Key facts:
- Enable per text format: the **`paragraphs_entity_embed`** filter ("Display embedded
  paragraphs") + the **Paragraphs** CKEditor 5 button (plugin
  `paragraphs_entity_embed_paragraphsEmbed`).
- Shipped `embed.button` config entity id **`paragraphs`** (embed type
  `paragraphs_entity_embed`); shipped view mode **`paragraph.embed`**.
- Storage entity: **`embedded_paragraphs`** (base fields `label`, `paragraph` =
  entity_reference_revisions → paragraph). Tables `embedded_paragraphs` / `_revision`.
- Permissions: `view` / `add` / `edit` / `delete` / `administer paragraphs entity embed`.
- Inserted markup: `<drupal-paragraph data-embed-button data-paragraph-id
  data-paragraph-revision-id data-entity-label data-align>`.
