<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notes modal form (AddNoteForm)

`src/Form/AddNoteForm.php` — class `AddNoteForm extends FormBase`, form id
`add_entity_note_form`. Injects the `entity_note_block.storage` service (`NoteStorage`).

## Route

`entity_note_block.routing.yml`:
- `entity_note_block.notes_form` — path `/entity-notes/custom-block-entity/notes`,
  `_form: \Drupal\entity_note_block\Form\AddNoteForm`, `_title: 'Entity Notes'`,
  requirement `_permission: 'view entity notes'`.

Opened as a modal by the block's `use-ajax` link (width 600).

## buildForm()

- Wraps output in `<div id="entity-note-form-wrapper">` (AJAX replace target).
- Loads `$this->noteStorage->getNotes()` (all rows) and renders a `#type => table`
  (id `note-table`, header Date/Note/Edit/Delete, `#empty` "No notes yet.").
- Each row: `date` = `date('Y-m-d H:i', $note->created)` as `#markup`; `note` = `$note->note`
  as `#markup`; an **Edit** submit (`#name` `edit_<id>`, AJAX `::loadNote`) and a **Delete**
  submit (`#name` `delete_<id>`, AJAX `::deleteNote`, class `delete-note-btn`).
- `note` textarea (id `edit-note`, 4 rows, default from `$form_state->get('edit_note')`).
- `edit_entity_id` hidden field (id `edit-entity-id`, default from
  `$form_state->get('edit_entity_id')`) — holds the record id when editing.
- Actions: **Save** (AJAX `::saveAjax`), **Clear** (button, AJAX `::clearAjax`), **Close**
  (plain button), **Reload** (button, class `reload-button-note-form`, AJAX `::reloadAjax`).
- Attaches `core/drupal.dialog.ajax` and `entity_note_block/note_form_styles`.

## AJAX callbacks

- `saveAjax()`: reads `note` + `edit_entity_id`. If `edit_entity_id` is non-empty →
  `updateNote($entity_id, $note)`. Otherwise `$entity_id = saveNoteWithNode($note)` then
  `saveNote($entity_id, $note)` (double write: creates the note_log node, then a table row keyed
  by that node id). Returns an `AjaxResponse` that blanks `#edit-note` / `#edit-entity-id` and
  triggers a click on `.reload-button-note-form`.
- `loadNote()`: takes the trigger `#name` `edit_<id>`, strips `edit_`, calls
  `getNotesValue($id)`, and sets the textarea + hidden id via `InvokeCommand('…','val',[…])`.
- `deleteNote()`: strips `delete_` from the trigger `#name`; if numeric,
  `deleteNote((int) $entity_id)`; then triggers a reload.
- `clearAjax()` / `reloadAjax()`: blank the fields / return the rebuilt form.
- `submitForm()` is empty — all work happens in the AJAX callbacks.

`getFormId()` returns `add_entity_note_form`. Standard `FormBase` handling applies (core form
token is present on the rendered form).
