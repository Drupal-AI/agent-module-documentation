<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inline Entity Form Dialog provides an entity_reference field widget that edits referenced entities in Drupal's native modal dialog instead of embedding a nested form inline.

---

It is a stable alternative to the Inline Entity Form module. Rather than embedding a full Drupal form inside the parent form (the source of IEF's nested form-state, cascading-AJAX and submit-ordering bugs), this widget renders each referenced entity's own add/edit form as a completely separate page request inside a `ui-dialog` modal. The parent form stores only a JSON array of entity IDs in a hidden input; on save it returns the canonical `['target_id' => $id]` array via `massageFormValues()`, exactly like any other reference widget. When the dialog form saves, a custom `UpdateEntityReferenceCommand` AJAX command appends the pre-rendered item row and closes the dialog without rebuilding the parent form.

Operationally you switch the widget on Manage form display and optionally set a form mode, dialog width and whether add/edit are allowed. Security note: the two dialog routes (`/inline-entity-form-dialog/{entity_type_id}/{bundle}/add` and `.../{entity_id}/edit`) are gated only by the `access administration pages` permission; they build the target entity form via the entity form builder but do not additionally check the parent entity's create/update access, so grant this permission only to trusted editors.

Set-up is: enable the module, go to Manage form display for an entity type with an entity_reference field, choose the "Inline Entity Form Dialog" widget, and configure its settings via the gear icon.

---

- Switch an entity_reference field to the "Inline Entity Form Dialog" widget on Manage form display.
- Add a new referenced entity through a modal add form without leaving the parent page.
- Edit an existing referenced entity in a modal edit form.
- Remove a reference row without deleting the underlying entity.
- Reorder referenced items via drag-and-drop, persisted on parent submit.
- Add an existing entity by autocomplete at the bottom of the widget.
- Pick a custom entity form mode to show only dialog-relevant fields.
- Set a per-widget dialog width (300–2000px).
- Disable "Add" to make a reference-only widget.
- Disable "Edit" to prevent in-place editing of referenced entities.
- Replace nested Inline Entity Form widgets that suffer nested form-state bugs.
- Use it on nodes, block_content, media, or any entity type with a reference field.
- Rely on the automatic hiding of "Add" when cardinality is reached.
- Keep the parent form from rebuilding when a referenced entity is saved.
- Restrict access by granting "access administration pages" only to trusted editors.
- Build reference widgets that avoid cascading AJAX failures on parent-form rebuilds.
- Troubleshoot a non-appearing row by checking the browser console for IEFD wrapper errors.