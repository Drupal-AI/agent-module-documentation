# Bricks Dynamic — agent index

Adds a Dynamic-Entity-Reference-based Bricks field so one tree can reference multiple entity types.
Parent: Bricks ([../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)). Depends on `bricks`,
`dynamic_entity_reference`, `inline_entity_form`.

Plugins:
- Field type `bricks_dynamic` (`BricksTreeDynamicItem` = `DynamicEntityReferenceItem` +
  `BricksFieldTypeTrait`; default widget `bricks_tree_dynamic`, default formatter
  `bricks_nested_dynamic`).
- Widgets `bricks_tree_dynamic` (autocomplete, extends `DynamicEntityReferenceWidget`) and
  `bricks_tree_dynamic_inline` (extends `InlineEntityFormComplex`, `multiple_values = true`).
- Formatter `bricks_nested_dynamic` (extends the DER entity formatter).

Key facts:
- Same `depth` + serialized `options` model as core Bricks (via `BricksFieldTypeTrait`); nesting/render
  reuse the parent's `Bricks` helper — see [../../../../2.1.x/agent/api/rendering.md](../../../../2.1.x/agent/api/rendering.md).
- Use this instead of plain `bricks` when the field must target more than one entity type.
- No config UI, permissions, or Drush.
