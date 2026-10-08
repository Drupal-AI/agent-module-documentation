<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Attach internal, staff-only notes using a block that opens an AJAX modal for adding, editing, and deleting notes.

---

Entity Note Block ships a single block plugin ("Entity Note Block") that renders an "Add/View Notes" button. Clicking it opens a core AJAX modal dialog containing a form: a table listing existing notes (with date, edit, and delete actions) plus a textarea for writing a new note. All actions — save, edit, delete, clear, reload — happen in-place via AJAX with no page reload. Notes are stored in a dedicated `entity_note_block` database table through the `entity_note_block.storage` service; on each new note the module also creates an unpublished `note_log` node (auto-creating that content type and its `field_entity_notes` field on first use). The module depends only on Drupal core (node/field/block), works on Drupal 10, 11, and 12, and exposes two permissions ("view entity notes", "add entity notes"). Notes are intended for internal editorial use, so place the block and grant its permissions to trusted staff only.

---

- Give editors a scratchpad for internal notes without touching public content.
- Place the notes block in a sidebar or content region via Structure → Block layout.
- Let staff record editorial decisions and hand-off comments.
- Keep moderation reasoning in one AJAX modal instead of scattered emails.
- Add, edit, and delete notes without leaving the current page (full AJAX CRUD).
- Review all recorded notes in a dated table inside the modal.
- Store notes in a dedicated database table for later querying/reporting.
- Mirror each saved note as an unpublished `note_log` node for archival.
- Build Views listings over `note_log` nodes when you need reports.
- Restrict access to the notes feature to trusted roles via the "view entity notes" permission.
- Add the notes block to admin-facing or staff-only pages only.
- Track content review status as free-text notes.
- Leave setup/config instructions for other admins on a page.
- Use the `entity_note_block.storage` service to read notes programmatically.
- Use the service to create, update, or delete notes from custom code.
- Coordinate multi-editor workflows with shared internal notes.
- Provide a lightweight alternative to full comment or workflow modules.
- Run on Drupal 10, 11, or 12 with core only (no contrib dependencies).
- Style the modal form via the bundled `note_form_styles` library.
- Reload the notes table on demand with the modal's Reload button.
- Clear the note textarea quickly with the modal's Clear button.
- Close the modal without a page refresh.
- Attach the block to Layout Builder layouts where blocks are allowed.
