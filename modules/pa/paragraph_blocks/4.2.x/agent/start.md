# Paragraph Blocks — agent index

Exposes each value of a multi-value paragraph field as an individual **Layout Builder block**
(category "Paragraphs", base plugin `paragraph_field`), so editors place specific paragraph
items into a layout. Requires `paragraphs` + `ctools`.

- **Global settings (`paragraph_blocks.settings`), per-field enable, per-type default title** →
  [configure/settings.md](configure/settings.md)
- **The derived `paragraph_field` block plugin, its ids, and the `admin_title` field** →
  [plugins/blocks.md](plugins/blocks.md)

Key facts: config object `paragraph_blocks.settings` (route `paragraph_blocks.settings` at
`/admin/config/content/paragraph_blocks`, permission `administer paragraphs settings`);
per-field toggle = `field.field.<…>.third_party_settings.paragraph_blocks.status`; adds an
`admin_title` base field to `paragraph` entities; cardinality-1 fields are not exposed.
