# Bricks Revisions — agent index

Submodule of **Bricks**. Adds a `bricks_revisioned` field type built on Entity Reference Revisions
(ERR) so a Bricks tree references *revisions* of its brick entities, letting the whole tree
participate in the host entity's revision history (new revision / revert). Same drag-and-drop tree,
`depth` and per-item `options` model as core Bricks — only the reference storage differs.

Parent: Bricks → [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md).
Depends on `bricks` and `entity_reference_revisions`. No admin page (`configure` null); config schema
present; no permissions, no Drush, no hooks, no routes.

- **The `bricks_revisioned` field type, its widget/formatters, ERR revision behavior, config schema, how to add the field** → [fields/field.md](fields/field.md)
- **How the flat tree becomes nested render output (shared `Bricks` helper, depth, per-item options)** → parent [../../../../2.1.x/agent/api/rendering.md](../../../../2.1.x/agent/api/rendering.md)
- **Widgets, per-item options UI, formatter behavior (shared with core Bricks)** → parent [../../../../2.1.x/agent/configure/field.md](../../../../2.1.x/agent/configure/field.md)

Key facts:
- Field type `bricks_revisioned` (`BricksTreeRevisionedItem` = core `EntityReferenceRevisionsItem` +
  `BricksFieldTypeTrait`; annotation category `Reference revisions`). Adds `depth` (tinyint) + serialized
  `options` blob to ERR storage, exactly like the `bricks` field type does to entity_reference.
- Default widget `bricks_tree_autocomplete`; default formatter `bricks_nested` (the parent formatter,
  which also lists `bricks_revisioned` in its `field_types`).
- Extra formatter `bricks_revisions_nested` (`BricksRevisionsNestedFormatter` extends
  `EntityReferenceRevisionsEntityFormatter`) for ERR-aware rendering.
- `bricks_field_widget_info_alter()` (parent) makes `bricks_revisioned` usable by any
  `entity_reference_revisions` widget; the inline / paragraphs / dynamic submodule widgets also accept it.
- The parent's Replicate integration (`BricksServiceProvider` → `ReplicateFieldSubscriber`) is wired
  specifically to the `bricks_revisioned` field so clones duplicate the referenced revisions.
- Config schema keys: `field.storage_settings.bricks_revisioned`, `field.field_settings.bricks_revisioned`,
  `field.widget.settings.bricks_tree_autocomplete`, and a remap of `field.formatter.settings.bricks_nested`
  to the ERR view schema.
