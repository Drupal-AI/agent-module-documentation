Turns a core entity reference field into a drag-and-drop rooted tree by storing a depth value on each reference and deriving parent/child structure from row order plus depth.

---

Entity Reference (with) Hierarchy provides a new field type, `entity_reference_hierarchy`, that behaves exactly like core's `entity_reference` but adds a single tiny `depth` integer column to every reference item. The multi-value widget renders the field as a tabledrag tree — the same drag-and-drop UI used for taxonomy terms and menu links — where indentation sets each row's depth and row order sets sibling weight. Because the entire tree lives on one field on the host entity (not spread across chained parent-reference fields), the parent/child outline is computed in-memory from delta + depth by `getFieldHierarchyOutline()`; there is no separate join table or query service. Two "with hierarchy" formatters render the referenced entities as nested ordered/unordered lists, and a `hook_field_formatter_info_alter` makes all standard entity_reference formatters available on the field too. Three optional submodules extend it to Entity Reference Revisions, Inline Entity Form, and Paragraphs so nested revisioned or paragraph-based layouts can be authored on the same field. It requires no external services, no routes, and no permissions of its own.

---

- Add a hierarchical entity reference field to a content type to model chapters containing sections.
- Build a product catalogue with sub-categories inside a single node field.
- Author a nested Paragraphs layout using the Paragraphs Classic hierarchy widget.
- Give an organisation chart real parent-child structure stored as content data.
- Drag rows to re-parent and re-order references together in one tabledrag table.
- Set each reference's depth by indenting it under a sibling in the edit form.
- Order siblings by dragging rows up and down (weight = field delta).
- Render referenced entities as a nested ordered or unordered list on the display.
- Show referenced entities' labels as a nested tree with the Label (with hierarchy) formatter.
- Reuse any core entity_reference formatter on a hierarchy field via the formatter_info_alter hook.
- Reference specific entity revisions in a tree with the Revisions submodule.
- Track and revision an entire hierarchical structure alongside the host entity.
- Use the Inline Entity Form complex widget to create/edit referenced entities inline with depth.
- Model deeply nested component layouts without chaining reference fields across entities.
- Compute a node's descendants in code from the field's outline array.
- Compute a node's ancestors/parent from the same outline without extra queries.
- Attach the drag handle, order, depth and match-parent tabledrag behaviours to a custom form.
- Replace a menu-only structure with hierarchy that Views and the API can read.
- Keep hierarchy queryable because depth is stored per reference item.
- Migrate a flat multi-value reference field to a tree by populating the depth column.
- Provide editors a familiar taxonomy-style drag interface for arbitrary reference fields.
- Build breadcrumbs derivable from real content structure rather than menu placement.
