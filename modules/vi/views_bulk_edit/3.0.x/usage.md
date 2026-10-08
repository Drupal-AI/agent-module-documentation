Views Bulk Edit (VBE) adds a "Modify field values" action that lets you change the field values of many entities of any type at once, from a View. It works with Drupal core Actions and, preferably, with the Views Bulk Operations (VBO) module.

---

VBE provides a bulk action that renders an entity edit form for every bundle present in the selection, lets you tick exactly which fields to change, and applies those values to all selected entities. It ships two Action plugins that do the same work through different mechanisms: `views_bulk_edit` (a VBO action, extending `ViewsBulkOperationsActionBase`) and `entity:edit_action` (a core Action, derived per fieldable entity type, that stashes the selection in a private tempstore and drives a confirm form at `/admin/content/bulk-edit`). The fields offered come from each bundle's **`bulk_edit`** entity form-mode display — define that form mode to control which fields are bulk-editable; otherwise the default display is used. A `_field_selector` fieldset of checkboxes decides which fields are actually written, and each selected field gets a **change method**: *Replace* (always), *Append to the current value* (string/text fields), or *Add a new value* (multi-value fields). Revisionable entities also get a "Create new revision" toggle with a revision log message. The VBO action adds a preconfiguration option, "Get entity bundles from results", to trade a DB query for accuracy on large result sets. Access is gated per entity by `update` permission plus the module's own `use views bulk edit` permission on the confirm route. VBE is authored by Marcin Grabias and depends on nothing beyond Drupal core, though VBO is strongly recommended for batching, "select all results", and persistent cross-page selection.

---

- Change a field on hundreds of nodes at once (e.g. set an author, category, or flag) from a View.
- Bulk-set a taxonomy term reference across many pieces of content.
- Update a status/boolean field on all selected entities in one operation.
- Append a disclaimer or note to the body/text field of many entities (Append change method).
- Add a new value to a multi-value field (e.g. add one tag) without wiping existing values.
- Replace a field's value outright on every selected entity.
- Bulk-edit users (e.g. set a field) via the derived `entity:edit_action:user` action.
- Bulk-edit media entities' metadata fields across a media library View.
- Bulk-edit taxonomy term fields across a vocabulary.
- Edit fields on mixed entity types in a single View — VBE renders a form section per bundle.
- Limit which fields are exposed for bulk editing by defining a `bulk_edit` form mode per bundle.
- Create a new revision for each edited entity, with a shared revision log message.
- Use VBO's "select all results in this view" to edit every matching entity, not just the current page.
- Batch huge edits through VBO's Batch API to avoid timeouts.
- Keep a selection across paged View results while choosing what to edit (VBO tempstore).
- Restrict who can perform bulk edits with the `use views bulk edit` permission.
- Fix a data-entry mistake applied to many nodes in one pass instead of editing each by hand.
- Roll out a taxonomy/field change site-wide after a content model update.
- Correct imported content in bulk by overwriting a mis-mapped field.
- Editorially retag or recategorize a batch of articles from a filtered View.
- Use core Actions only (no VBO) via the shipped `system.action.*_edit_action` config for node/user/media/taxonomy_term.
- Add the "Modify field values" action to a Table View for the most convenient editor UX.
- Avoid performance issues on large sets by unchecking "Get entity bundles from results" and using a bundle filter.
- Export a View that includes the VBE action as normal configuration (config schema provided).
