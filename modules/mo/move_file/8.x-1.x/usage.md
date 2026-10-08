<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Move File relocates a node's attached files into a target folder chosen by the node's taxonomy term whenever the node is saved.

---

The module defines a `move_file_directory` config entity mapping a taxonomy term to a target directory (path plus a public/private scheme flag). On `hook_node_insert` and `hook_node_update`, `MoveFileService::move()` checks whether the node's content type is enabled, reads the selected term ids from the configured vocabulary field, finds the matching directory entity, builds `<scheme>://<path>/<filename>`, and calls `file.repository`'s `move()` for each file in the configured file fields (only when the target URI differs from the current one).

All configuration lives under admin routes at `/admin/config/media/move-file*` gated by the `administer move_file` permission: a settings form (which vocabulary/fields per content type), a content-types form, and a CRUD UI for directory entities. Directory paths and the term→directory mapping are admin-defined; grant the `administer move_file` permission only to trusted roles.

---
- Auto-sort uploaded files into folders by a node's category term.
- Move press files into a private directory when a node is marked confidential.
- Keep public downloads organised by taxonomy without manual filing.
- Route images to per-department folders based on a term selection.
- Relocate attachments automatically when an editor re-categorises a node.
- Map each vocabulary term to its own destination directory.
- Choose public or private scheme per directory.
- Apply moves across multiple file/image fields on a content type.
- Enable the behaviour only for selected content types.
- Move files into private storage to enforce access control by category.
- Reorganise an existing library by re-saving nodes after configuring terms.
- Keep file URIs consistent with editorial taxonomy.
- Avoid a flat, unmanageable public files directory.
- Separate archived vs. active assets by term.
- Centralise file-placement rules in configuration entities.
- Trigger re-filing simply by editing a node's term and saving.
