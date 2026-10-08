<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Note Block (entity_note_block) — agent index

Internal-notes tool: one **block** renders an "Add/View Notes" button that opens a core
**AJAX modal** with a form for adding/editing/deleting free-text notes. Notes live in a custom
DB table (`entity_note_block`) via a service; each new note also creates an unpublished
`note_log` node. Package **Note Block**. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version 1.0.1. **Core-only** — no contrib dependencies declared; uses core node/field/block APIs.

## What it actually provides

- **Block plugin** `EntityNoteBlock` (id `entity_note_modal_button_block`, label "Entity Note
  Block") in `src/Plugin/Block/EntityNoteBlock.php`. `build()` returns a `use-ajax` modal
  `Link` to route `entity_note_block.notes_form`. → [plugins/block.md](plugins/block.md)
- **Modal form** `AddNoteForm` (`src/Form/AddNoteForm.php`, form id `add_entity_note_form`) at
  route `entity_note_block.notes_form`, path `/entity-notes/custom-block-entity/notes`, route
  requirement `_permission: 'view entity notes'`. Table of notes + textarea + AJAX
  Save/Edit/Delete/Clear/Reload. → [forms/notes-modal.md](forms/notes-modal.md)
- **Storage service** `entity_note_block.storage` = `NoteStorage` (`src/Service/NoteStorage.php`,
  arg `@database`): getNotes / getNotesValue / saveNote / saveNoteWithNode / updateNote /
  deleteNote. DB table schema in `entity_note_block.install`. → [api/note-storage.md](api/note-storage.md)
- **Permissions** (`entity_note_block.permissions.yml`, both `restrict access: TRUE`):
  `view entity notes`, `add entity notes`.
- **Library** `entity_note_block/note_form_styles` (`css/note-form.css`). Block + form attach
  `core/drupal.dialog.ajax`.
- `hook_help()` in `entity_note_block.module`. Install schema in `entity_note_block.install`.
  No config objects/schema, no settings route, no Drush, no submodules.

## Install / operate

`drush en entity_note_block`, then Structure → Block layout → place "Entity Note Block". No
configuration needed. Grant the two permissions to trusted staff. First note save auto-creates
the `note_log` content type and `field_entity_notes` field.
