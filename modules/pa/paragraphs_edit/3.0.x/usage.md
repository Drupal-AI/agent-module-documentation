Paragraphs Edit adds contextual edit, clone, and delete links to rendered paragraphs and dedicated per-paragraph routes/forms, so an editor can change one paragraph directly without opening the entire host entity's edit form.

---

Paragraphs Edit builds on the Paragraphs module and core's Contextual Links. On any rendered paragraph (outside admin/QuickEdit contexts) it attaches a `paragraph` contextual-links group offering **Edit**, **Clone**, and **Delete**, each pointing at a dedicated route under `/paragraphs_edit/{root_parent_type}/{root_parent}/paragraphs/{paragraph}/…`. To reach a deeply nested paragraph the module walks the parent chain up to the top host entity (its "root parent") via the `paragraphs_edit.lineage.inspector` service, and route access is checked with core entity access (`root_parent.update` for edit/delete, `paragraph.update` for clone) rather than a module-specific permission. The edit form (`ParagraphEditForm`, form op `entity_edit`) renders just that paragraph's fields, with translation-aware initialization; the delete form (`ParagraphDeleteForm`, `entity_delete`) removes the item from its parent field and re-saves the parent; the clone form (`ParagraphCloneForm`, `entity_clone`) duplicates the paragraph and lets you pick a destination entity type, bundle, parent entity, and target field before appending it there. Saving is revision-aware: `ParagraphLineageRevisioner` checks whether the root/parent bundle is configured to create new revisions by default and, if so, saves the whole lineage (paragraph plus every ancestor) as new revisions, keeping `target_revision_id` references consistent. The module provides no config UI, no settings, and no permissions of its own — enabling it (with `contextual` and `paragraphs`) is the entire setup. Two services (`paragraphs_edit.lineage.inspector`, `paragraphs_edit.lineage.revisioner`) and a `ParagraphFormHelperTrait` are available for programmatic reuse.

---

- Edit a single paragraph in the middle of a long page without loading the whole node edit form.
- Use the contextual "Edit paragraph" link that appears when hovering a rendered paragraph.
- Delete one paragraph directly from the front end via its contextual "Delete paragraph" link.
- Clone an existing paragraph and place the copy on a different node, field, or entity.
- Move/copy a paragraph between two different host entity types (e.g. node to a custom entity) through the clone form.
- Reach and edit a deeply nested paragraph (paragraph-inside-paragraph) via its own edit route.
- Fix a typo in one paragraph on a large landing page quickly without disturbing sibling content.
- Preserve revision history by editing a paragraph on a node whose bundle creates new revisions by default.
- Save a whole paragraph lineage (paragraph + all ancestors) as new revisions in one edit operation.
- Translate an individual paragraph, letting the edit form auto-create the translation from the host's source language.
- Give editors a focused edit form showing only the fields of the targeted paragraph.
- Gate paragraph edit/delete on the host entity's update access, and clone on the paragraph's own update access.
- Remove a paragraph and re-save its parent field in a single confirm-form submission.
- Duplicate a complex paragraph as a starting point instead of rebuilding it field by field.
- Route paragraph edit forms through admin theme rendering (routes are marked `_admin_route`).
- Avoid QuickEdit JS conflicts — contextual links are suppressed inside QuickEdit field forms.
- Present a human-readable lineage title (e.g. "Node title > Field #2 (Bundle)") on the edit/clone/delete forms.
- Programmatically find a paragraph's root parent host entity using the lineage inspector service.
- Programmatically locate the parent field and field item a paragraph is referenced from.
- Build a string breadcrumb of a paragraph's ancestry for logging or custom UIs via `getLineageString()`.
- Reuse `ParagraphLineageRevisioner::saveNewRevision()` to save an entity lineage as new revisions in custom code.
- Check whether a bundle is set to create new revisions by default before saving in custom code.
- Add paragraph edit/clone/delete affordances to a decoupled or custom rendering by attaching the same contextual-links group.
- Let content teams manage page sections independently without full-node lock/edit cycles.
