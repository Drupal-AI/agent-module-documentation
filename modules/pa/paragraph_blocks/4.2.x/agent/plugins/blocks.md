# The `paragraph_field` block plugin

Paragraph Blocks does not define a plugin *type*; it provides one **block plugin** with a
deriver.

## Plugin

- Base id: **`paragraph_field`** (`src/Plugin/Block/ParagraphBlock.php`,
  `@Block(id="paragraph_field", deriver=…ParagraphBlocksDeriver, category=@Translation("Paragraphs"))`).
- Derivative id format: **`{entity_type}:{field_name}:{delta}:{bundle}`**, e.g.
  `paragraph_field:node:field_paragraphs:0:page` → full plugin id
  `paragraph_field:node:field_paragraphs:0:page`.
- Each derivative renders **one delta** of a paragraph reference field on the host entity,
  in the block's chosen view mode.

## Deriver rules (`ParagraphBlocksDeriver`)

For every non-`paragraph` entity type and each field storage of type
`entity_reference_revisions` targeting `paragraph`:

- **Cardinality 1 fields are skipped** (place them as a normal field instead).
- **Unlimited (-1) fields** are offered up to `paragraph_blocks.settings:max_cardinality`
  (default 10) deltas.
- One derivative is created per bundle per delta, with an admin label like
  "*<field label> item <delta>*".
- The `paragraph_blocks.labeller` service later removes unavailable items and overrides the
  block labels using each paragraph's admin title.

## `admin_title` base field

`hook_entity_base_field_info()` adds a translatable, revisionable **`admin_title`** string
field to `paragraph` entities (form widget weight -10). It identifies each paragraph in the
block-placement UI and becomes the block's label. A paragraph type's
`default_admin_title` third-party setting pre-fills it on creation.

## Related hooks

- `paragraph_blocks_plugin_filter_block__layout_builder_alter()` — trims/relabels the block
  list shown in Layout Builder's "Add block" chooser.
- `paragraph_blocks_entity_presave()` — keeps Layout Builder configuration in sync with
  paragraph order (skips while a Workspace is syncing).
