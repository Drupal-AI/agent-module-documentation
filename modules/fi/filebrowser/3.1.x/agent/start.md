# Filebrowser — agent index

Renders server directories as FTP-like, browsable file listings inside Drupal. Each listing
is a **`dir_listing` node** pointing at a folder URI; per-node settings live in the module's
`filebrowser_nodes` table (not Fields), and global defaults live in `filebrowser.settings`.

- **Global defaults & the settings form** (`filebrowser.settings`, `/admin/config/system/filebrowser`) →
  [configure/settings.md](configure/settings.md)
- **Create/read a directory-listing node (folder URI, per-node rights, storage table)** →
  [configure/dir-listing-node.md](configure/dir-listing-node.md)
- **Permissions the module defines and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)
- **Services, the `Filebrowser` value object, and the metadata event API (extra columns)** →
  [api/services-and-events.md](api/services-and-events.md)

Key facts:
- `configure` route = `filebrowser.settings`. Dependencies: `node`, `system`.
- Per-node data table `filebrowser_nodes` (nid, folder_path, serialized `properties`); the
  file listing is cached in `filebrowser_content`.
- Permission machine names are terse: `view listings`, `download files`, `upload files`,
  `create listings`, `rename files`, `delete files`, `create folders`, `download archive`.
- **Known setup gap on this site:** `field.field.node.dir_listing.body` (the Body field
  instance shipped in `config/install`) is **missing**, so `dir_listing` nodes currently have
  no Body field. Do not repair core/other-module config to fix it.
