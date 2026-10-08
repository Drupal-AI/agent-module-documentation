Adds a revision-aware hierarchical field type so a tree can reference specific entity revisions, built on Entity Reference Revisions.

---

Entity Reference (with) Hierarchy Revisions is a submodule of Entity Reference (with) Hierarchy that provides the `entity_reference_hierarchy_revisions` field type. It combines core-style behaviour from the Entity Reference Revisions module (`EntityReferenceRevisionsItem`, which pins a target revision id) with the parent module's `EntityReferenceHierarchyItemTrait`, so each reference item stores both a specific revision and a `depth` value. The result is a rooted tree whose nodes point at fixed revisions — ideal for Paragraphs and other composite content where the whole nested structure should be revisioned with the host. It ships an autocomplete widget, a "Nested Rendered entity" formatter that reuses the parent module's outline and nested-list rendering, and config schema inheriting the Entity Reference Revisions storage and formatter settings. It depends on both `entity_reference_revisions` and `entity_reference_hierarchy`.

---

- Reference a specific entity revision inside a hierarchical tree field.
- Revision an entire nested Paragraphs layout together with its host entity.
- Provide the field type that the Paragraphs Classic hierarchy widget targets.
- Build a tree of composite/paragraph components that survives host revisions.
- Render referenced revisions as a nested ordered/unordered list.
- Use the Nested Rendered entity formatter for revision-pinned tree display.
- Author revisioned nested layouts with an autocomplete widget plus depth column.
- Track historical states of a hierarchical structure via entity_reference_revisions.
- Reuse the parent module's in-memory outline logic on revision references.
- Combine with Inline Entity Form's hierarchy widget (which also supports this field type).
- Model deeply nested revisioned components without chaining reference fields.
- Keep the whole tree's revision integrity when the host is reverted.
- Add a hierarchical revision field to a content type via Field UI.
- Reuse standard entity_reference_revisions formatters on the field (via the parent hook).
- Store depth per revision reference so structure is queryable in code.
