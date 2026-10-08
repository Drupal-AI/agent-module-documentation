<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage service, DB schema & permissions

## Service

`entity_note_block.services.yml`: `entity_note_block.storage` →
`Drupal\entity_note_block\Service\NoteStorage`, argument `@database`.

`src/Service/NoteStorage.php` — all methods use the DB API (parameterized queries) against the
`entity_note_block` table:

- `getNotes()` — `SELECT * FROM entity_note_block` → `fetchAll()` (every row, no filter).
- `getNotesValue($entity_id)` — one row `WHERE entity_id = :id` → `fetchObject()`.
- `saveNote($entity_id, $note)` — INSERT with `entity_type => 'entity_note_block'` (hardcoded
  constant, not the host entity's type), `entity_id`, `note`, `created => request time`.
- `saveNoteWithNode(string $note): int` — on first call creates content type `note_log`
  (label "Note Log") and the `field_entity_notes` `text_long` field
  (`FieldStorageConfig`/`FieldConfig`), then creates an **unpublished** node
  (`type note_log`, title "Note for entity", `field_entity_notes => $note`, `status 0`) and
  returns its nid. This nid is what `saveAjax()` then stores as the table row's `entity_id`.
- `updateNote($entity_id, $note)` — UPDATE `note` + `created` `WHERE entity_id = :id`.
- `deleteNote($entity_id)` — DELETE row `WHERE entity_id = :id`; then `Node::load($entity_id)`
  and delete it only if `bundle() === 'note_log'`.

Programmatic use:
```php
$s = \Drupal::service('entity_note_block.storage');
$nid = $s->saveNoteWithNode('Internal note');
$s->saveNote($nid, 'Internal note');
$all = $s->getNotes();
$s->updateNote($nid, 'Edited');
$s->deleteNote($nid);
```

Note the naming is misleading: the table's `entity_id` holds a `note_log` **node id** and
`entity_type` is the constant string `entity_note_block` — the module does not bind a note to the
arbitrary host entity being viewed.

## DB schema

`entity_note_block.install` `hook_schema()` → table `entity_note_block`:
`id` (serial PK), `entity_type` (varchar 64), `entity_id` (int unsigned), `note` (big text,
nullable), `created` (int unsigned). Index `entity_lookup` on (`entity_type`, `entity_id`).

## Permissions

`entity_note_block.permissions.yml` declares two permissions, both `restrict access: TRUE`:
`view entity notes` and `add entity notes`. The `entity_note_block.notes_form` route
requires `view entity notes`.

Grant only to trusted staff. No config objects, no config schema, no settings form, no Drush.
`hook_help()` (`entity_note_block.module`) prints a one-line description on the module help page.
