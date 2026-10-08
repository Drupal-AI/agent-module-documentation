Bricks Inline adds a `bricks_tree_inline` widget that lets editors build and edit a Bricks tree using Inline Entity Form, so referenced entities are created and edited in-place within the host form instead of via autocomplete.

---

The submodule provides one field widget, `bricks_tree_inline` (`BricksTreeInlineWidget`), extending Inline Entity Form's `InlineEntityFormComplex` and applying to the `bricks` and `bricks_revisioned` field types (`multiple_values = true`). It layers the Bricks tree UI onto IEF: `formElement()` tags each entities sub-form with the `bricks_tree_inline` widget and calls the parent module's `_bricks_form_element_alter()` on each row to inject the hidden `depth` field and the inline `options` controls (view mode / layout / css class / css id); `massageFormValues()` copies the submitted `depth` and `options` back onto each field value so they persist. `form()` marks the element `#multilingual` so content_translation treats the field as translatable rather than hiding it. This is the widget used by the `bricks_default_blocks` demo. Depends on `bricks` and `inline_entity_form`. No config UI, permissions, or Drush.

---

- Create and edit referenced bricks in-place (Inline Entity Form) instead of by autocomplete.
- Build a nested Bricks tree where each node is edited within the parent form.
- Keep per-item Bricks options (view mode, layout, css) editable inline per row.
- Preserve depth/options when saving an IEF-edited Bricks field.
- Support translating a Bricks field (widget marks it multilingual).
- Use with `bricks` or `bricks_revisioned` fields.
- Provide a Paragraphs-like inline editing experience on top of entity reference.
- Power the `bricks_default_blocks` demo editing UI.
- Let editors add new referenced entities without leaving the host content form.
- Combine inline creation with drag-and-drop tree indentation.
- Edit existing referenced entities in place rather than opening a separate form.
- Give a Paragraphs-like nested editing experience on entity-reference storage.
- Build a component tree where each item is authored inline.
- Persist per-row depth and options reliably through IEF save.
- Author a full landing page (bricks + subforms) from one node edit form.
- Add and remove bricks inline while keeping the tree structure intact.
- Use as the default editing widget in the `bricks_default_blocks` demo.
- Translate a Bricks field with inline sub-entities kept visible.
