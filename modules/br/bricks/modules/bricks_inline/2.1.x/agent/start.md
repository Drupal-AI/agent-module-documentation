# Bricks Inline — agent index

Adds the `bricks_tree_inline` widget: edit a Bricks tree with Inline Entity Form. Parent: Bricks
([../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)). Depends on `bricks`,
`inline_entity_form`.

Plugin:
- Widget `bricks_tree_inline` (`BricksTreeInlineWidget` extends IEF `InlineEntityFormComplex`),
  field types `bricks` + `bricks_revisioned`, `multiple_values = true`.

Key facts:
- `formElement()` injects the Bricks tree UI onto each IEF row via the parent's
  `_bricks_form_element_alter()` (hidden `depth` + inline `options`); `massageFormValues()` writes
  `depth`/`options` back onto each value.
- `form()` sets `#multilingual = TRUE` so content_translation keeps the field visible/translatable.
- This is the widget used by the `bricks_default_blocks` demo.
- No config UI, permissions, or Drush.
