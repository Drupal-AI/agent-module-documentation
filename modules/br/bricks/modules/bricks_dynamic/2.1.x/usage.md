Bricks Dynamic adds a `bricks_dynamic` field type built on Dynamic Entity Reference, letting a single Bricks tree reference items of several different entity types at once (e.g. nodes and custom blocks together), with autocomplete and Inline Entity Form widgets.

---

The submodule defines a `bricks_dynamic` field type (`BricksTreeDynamicItem`, extending `DynamicEntityReferenceItem` and mixing in `BricksFieldTypeTrait`, so it gains the same `depth` + serialized `options` as core Bricks), a matching nested formatter `bricks_nested_dynamic` (`BricksNestedDynamicFormatter` extending the DER entity formatter), and two widgets: `bricks_tree_dynamic` (autocomplete, extends `DynamicEntityReferenceWidget`) and `bricks_tree_dynamic_inline` (`InlineEntityFormComplex`). Because it uses Dynamic Entity Reference under the hood, one field can point at multiple target entity types, which plain `bricks` (single `target_type`) cannot. Rendering reuses the parent Bricks nesting logic. Depends on `bricks`, `dynamic_entity_reference`, and `inline_entity_form`. No config UI, permissions, or Drush.

---

- Reference more than one entity type (e.g. nodes AND blocks) in a single Bricks field.
- Build a page tree mixing different content/entity types as bricks.
- Edit mixed-type bricks inline with the dynamic inline widget.
- Use autocomplete to add bricks of any allowed target type.
- Keep per-item Bricks options (view mode, layout, css) on dynamically-referenced items.
- Render a mixed-type bricks tree with the `bricks_nested_dynamic` formatter.
- Compose components from heterogeneous entities without separate fields per type.
- Migrate a multi-field layout into one dynamic Bricks field.
- Leverage Dynamic Entity Reference's multi-target support inside Bricks.
- Combine reusable blocks and one-off nodes in the same nested structure.
- Keep the drag-and-drop tree UI while allowing heterogeneous item types.
- Avoid creating one Bricks field per entity type you want to reference.
- Author mixed-type components on a single content-edit form.
- Reference taxonomy terms and nodes together within one bricks tree.
- Model a flexible page builder that is not tied to a single target bundle.
- Preserve depth-based nesting across differently-typed referenced entities.
- Use `bricks_tree_dynamic` autocomplete for quick mixed-type additions.
- Adopt DER-based Bricks when a design needs cross-type composition.
