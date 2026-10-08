<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Move File (move_file) — agent index

**Moves a node's referenced files into a configured directory (public/private) chosen by the node's taxonomy term, on node insert/update.**

- **Version:** 8.x-1.x
- **Core:** ^9.1 || ^10
- **Depends:** none (uses core node/file/taxonomy)
- **Configure:** `/admin/config/media/move-file` (route `move_file.settings`), permission `administer move_file`.

**Surface:** settings form, content-types form, and a `move_file_directory` config-entity CRUD UI — all under `administer move_file`. Core logic in `MoveFileService::move()` via `hook_node_insert`/`hook_node_update`; uses `file.repository->move()`.

**Security:** directory paths and term→directory mappings are admin-configured. Treat `administer move_file` as a trusted-admin permission.
