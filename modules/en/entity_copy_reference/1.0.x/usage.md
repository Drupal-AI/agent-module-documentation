Entity Copy with Reference adds a configurable one-click "Copy" action to selected node types, duplicating a node and handling its entity-reference fields per your settings.

---

Entity Copy with Reference lets content managers duplicate a node in one click. On its admin config form you pick which content types get the Copy action, and for each enabled type you choose how every entity-reference (or entity-reference-revisions) field is treated when copying: keep the reference to the same target, clone the referenced entity too, or clear the reference. You can also set a per-type title prefix and suffix for copies. When a user copies a node, the module creates a duplicate (via `createDuplicate()`), applies the prefix/suffix to the title, marks the new node unpublished, sets the current user as author, and — for fields set to "clone" — recursively duplicates the referenced entities (for example paragraphs) so the copy is fully independent of the original. The Copy action appears as a node local task tab and as an entity operation, and runs through a confirmation form before creating the copy. It supports node entities only.

---

- Give editors a one-click "Copy" button on chosen content types.
- Duplicate a landing page and all of its paragraphs into an independent copy.
- Clone a node while keeping shared references (e.g. author, category) pointing at the same targets.
- Clone a node while clearing selected references so the copy starts fresh.
- Configure per content type which reference fields are copied, kept, or cleared.
- Add a "Copy of " title prefix to every duplicate of a given type.
- Add a versioning suffix (e.g. " (draft)") to copied node titles.
- Create a new unpublished draft from an existing published node.
- Reassign copied content to the editor who performed the copy.
- Spin up template-style base nodes editors can duplicate and adjust.
- Duplicate complex Paragraphs-based pages without manually rebuilding components.
- Let content teams fork a page for A/B or seasonal variants.
- Reuse an existing node's structure for a similar new piece of content.
- Copy a node from its edit form via the Copy local task tab.
- Copy a node from the content admin list via the entity operations dropdown.
- Restrict copying to specific content types by enabling them on the config form.
- Handle entity-reference-revisions fields (Paragraphs) as deep clones.
- Confirm each copy through a dedicated confirmation step before it is created.
- Keep the original node untouched while editing the duplicate.
- Standardize how a site handles node duplication across editors.
- Reduce manual re-entry when producing many similar nodes.
