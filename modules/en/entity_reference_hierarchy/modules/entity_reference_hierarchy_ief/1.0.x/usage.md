Lets an Inline Entity Form complex widget be used on hierarchy fields, adding a depth column so referenced entities can be created and nested inline.

---

Entity Reference (with) Hierarchy for Inline Entity Form is a submodule that integrates the hierarchy field types with the Inline Entity Form (IEF) module. It provides the `inline_entity_form_hierarchy` field widget, extending IEF's `InlineEntityFormComplex`, so editors can create and edit the referenced entities directly inline while also building the tree. The widget adds a `depth` textfield to each inline entity row and, via a preprocess hook, appends a Depth column with drag-and-drop tabledrag re-parenting to the IEF entity table (reusing the parent module's `tabledrag.relationship-all` library). It targets both the `entity_reference_hierarchy` and `entity_reference_hierarchy_revisions` field types, and merges each row's depth back into the saved field values in `massageFormValues()`. It depends on the `inline_entity_form` module.

---

- Create and edit referenced entities inline while building a hierarchy tree.
- Use the IEF complex widget on an entity_reference_hierarchy field.
- Use the IEF complex widget on an entity_reference_hierarchy_revisions field.
- Add a depth column to the Inline Entity Form entity table.
- Drag inline entity rows to re-parent and re-order them.
- Build nested content structures without leaving the host entity form.
- Author a tree of inline-created child entities with per-row depth.
- Set each inline row's nesting level with a small depth field.
- Combine inline entity creation with the familiar tabledrag tree UI.
- Manage a hierarchy of revisioned inline entities (with the revisions field type).
- Replace the plain autocomplete widget with an inline-form tree widget.
- Keep depth values in sync when IEF saves the field.
- Model nested layouts where child entities are edited in place.
- Provide editors one form to both create children and arrange the tree.
- Extend InlineEntityFormComplex behaviour with hierarchy depth support.
