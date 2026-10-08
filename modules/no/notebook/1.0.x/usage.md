<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notebook is a small admin tool for keeping notes (subject, body and an optional 10-digit phone number) in a dedicated `notebook_table` database table.
---
It exposes a set of routes under paths like `notebook/page`, `add/notes`, `notes/desplay`, `see/note`, `edit/note`, `edit/note_page` and `remove/note`. The main page combines an add-note form with a paged (4 per page) list of saved notes; each row links to a view page and a JavaScript-driven remove link. Notes can be viewed, edited and deleted. All create/read/update/delete goes through the Drupal database API with parameterised conditions, and the phone field is validated to ten digits.

Every route requires the `administer notebook` permission, so the notebook is not exposed to anonymous users. There is no per-user ownership column, so it is a single shared notebook for everyone holding that permission rather than private per-user notes. Several handlers read identifiers straight from `$_REQUEST`/`$_GET` (e.g. `show_id`, `edit_id`, `id`). Setup is just enabling the module and granting the permission; there is no settings form.
---
- Jot down a quick note with a subject and body
- Attach a 10-digit contact phone number to a note
- View all saved notes in a paged table (4 per page)
- Open a single note to read its full body and phone
- Edit an existing note's subject, body or phone
- Delete a note you no longer need
- Keep lightweight reminders inside the Drupal admin
- Maintain a shared team scratchpad for admins
- Record follow-up contact numbers alongside notes
- Reach the notebook from its admin menu link
- Add a note directly at `add/notes`
- List notes directly at `notes/desplay`
- Store short operational memos without creating nodes
- Paginate through a long history of notes
- Grant the `administer notebook` permission to trusted staff only
- Capture ad-hoc todo items during admin work
- Keep contact details for a task in one place
- Review note creation dates in the listing
- Use as a minimal example of a custom-table CRUD module
- Back up notes by exporting the `notebook_table` table
