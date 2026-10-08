# Bricks — agent index

A `bricks` field type: nest referenced entities into a drag-and-drop tree, rendered recursively. Built
on core Entity Reference + display modes + Layout API + tabledrag. Works with ANY entity type. No admin
page (`configure` null); config schema present; no permissions, no Drush.

- **The field type / widgets / formatter, per-item options, how to add a Bricks field** →
  [configure/field.md](configure/field.md)
- **How the flat tree becomes nested output: `Bricks` helper, depth, layout regions, access** →
  [api/rendering.md](api/rendering.md)

Submodules (own docs under `../../modules/<name>/2.1.x/`):
- `bricks_default` — dummy backward-compat shim → [../../modules/bricks_default/2.1.x/agent/start.md](../../modules/bricks_default/2.1.x/agent/start.md)
- `bricks_default_blocks` — demo setup (Bricks + custom blocks) → [../../modules/bricks_default_blocks/2.1.x/agent/start.md](../../modules/bricks_default_blocks/2.1.x/agent/start.md)
- `bricks_default_paragraphs` — demo setup (Bricks + paragraphs) → [../../modules/bricks_default_paragraphs/2.1.x/agent/start.md](../../modules/bricks_default_paragraphs/2.1.x/agent/start.md)
- `bricks_dynamic` — reference multiple entity types in one field → [../../modules/bricks_dynamic/2.1.x/agent/start.md](../../modules/bricks_dynamic/2.1.x/agent/start.md)
- `bricks_inline` — Inline Entity Form widget → [../../modules/bricks_inline/2.1.x/agent/start.md](../../modules/bricks_inline/2.1.x/agent/start.md)
- `bricks_paragraphs` — paragraphs-widget-based Bricks widget → [../../modules/bricks_paragraphs/2.1.x/agent/start.md](../../modules/bricks_paragraphs/2.1.x/agent/start.md)
- `bricks_revisions` — revisioned Bricks (entity_reference_revisions) → [../../modules/bricks_revisions/2.1.x/agent/start.md](../../modules/bricks_revisions/2.1.x/agent/start.md)

Key facts:
- Field type `bricks` (`BricksTreeItem`) = `EntityReferenceItem` + `depth` (tinyint) + serialized
  `options` blob (`BricksFieldTypeTrait`).
- Default widget `entity_reference_autocomplete` (legacy `bricks_tree_autocomplete`); default formatter
  `bricks_nested`.
- `bricks_field_widget_info_alter()` makes the `bricks` type usable by ANY entity-reference-compatible
  widget; `_bricks_form_element_alter()` injects the hidden `depth` + inline `options` UI.
- Rendering: `bricks_preprocess_field()` -> `Bricks::nestItems()`; depths normalised on save by
  `bricks_entity_presave()` -> `Bricks::correctDepths()`.
- Integrations: Entity Usage tracker `bricks_field`; Replicate subscriber added when `replicate` exists
  (`BricksServiceProvider`).
