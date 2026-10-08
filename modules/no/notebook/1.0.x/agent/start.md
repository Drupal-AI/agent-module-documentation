<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notebook (notebook) — agent index

**Stores admin notes (subject/body/phone) in a custom `notebook_table` with full CRUD routes.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Permission:** all routes require `administer notebook`.
- **Routes:** `notebook.page` (`notebook/page`, form + list), `note.notebook` (`add/notes`), `notes_display` (`notes/desplay`), `see_note_page` (`see/note`), `edit_note_form` (`edit/note`), `edit_not_controller` (`edit/note_page`), `delete_note_page` (`remove/note`).
- **Storage:** custom DB table, no `uid` — a single shared notebook, not per-user private notes.
- **Security:** admin-permission-gated, no anonymous access. The delete route (`remove/note`, `RemoveNote::removeThisNote`) reads `$_GET['id']`. Identifiers are read from `$_REQUEST`/`$_GET` in SeeNote/EditNoteForm; DB access is parameterised.

See [configure/notes.md](configure/notes.md)
