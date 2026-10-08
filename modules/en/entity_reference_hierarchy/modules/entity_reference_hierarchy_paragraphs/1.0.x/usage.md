Adds a Paragraphs Classic widget with a depth column so nested paragraph layouts can be built on a single revisioned hierarchy field.

---

Entity Reference (with) Hierarchy for Paragraphs is a submodule that integrates the hierarchy field with the Paragraphs module. It provides the `entity_reference_hierarchy_paragraphs` field widget (label "Paragraphs Classic"), extending Paragraphs' `InlineParagraphsWidget` and reusing the parent module's `EntityReferenceHierarchyWidgetTrait` to add a `depth` textfield to each paragraph row. A preprocess hook rebuilds the multi-value paragraphs form as a drag-and-drop tabledrag tree with a Depth column and indentation, reusing the parent module's `tabledrag.relationship-all` library. The widget targets the `entity_reference_hierarchy_revisions` field type, so deeply nested paragraph layouts can be authored on a single revisioned hierarchy field rather than by chaining reference fields across paragraphs. It depends on `paragraphs` and both parent hierarchy modules.

---

- Build a nested Paragraphs layout on one revisioned hierarchy field.
- Add depth to each paragraph row in the classic Paragraphs widget.
- Drag paragraphs to re-parent and re-order them in a tree.
- Author deeply nested component layouts without cross-entity field chaining.
- Model a page's sections and sub-sections as nested paragraphs.
- Use the Paragraphs Classic widget on an entity_reference_hierarchy_revisions field.
- Revision an entire nested paragraph tree with the host entity.
- Provide editors a taxonomy-style drag UI for paragraph nesting.
- Indent a paragraph to make it a child of the paragraph above.
- Reorder sibling paragraphs by dragging rows.
- Replace multiple nested paragraph reference fields with a single tree field.
- Render the nested paragraphs with the revisions Nested Rendered entity formatter.
- Create structured page-building content with real hierarchy data.
- Keep paragraph structure queryable via the stored depth column.
- Combine Paragraphs nesting with the parent module's outline API.
