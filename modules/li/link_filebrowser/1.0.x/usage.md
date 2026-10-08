<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link File Browser adds a file-explorer button to the link field widget.

---

Link File Browser **adds a file-explorer button to the link field widget** — letting editors browse a
configured folder (meant to be under `public://`) and pick a file/folder to insert into a link field, with a modal
file explorer. It provides its own permissions, in the Field types package.

Use it to pick files for link fields. Its file-listing endpoint (`ajax/list-files`, permission `view link file
browser`) lists the requested directory recursively and returns file/dir names and full paths as JSON. Grant
`view link file browser` only to trusted editor roles, and configure the widget's allowed folder.

---

- Add a file-explorer to the link widget.
- Browse a configured (public://) folder.
- Pick a file/folder into a link field.
- Provide its own permissions.
- Serve content editing/file picking.
- Show a modal file explorer.
- Return file/dir names + full paths as JSON (recursive).
- Grant 'view link file browser' only to trusted editor roles.
- Configure the widget's allowed folder.
- Handle link file browsing.
- Browse files.
- Configure the folder.
- Pick files.
- Handle the widget.
- List files.
- Restrict the permission.
- Provide a link file browser.
