# Protected File — agent index

Adds a `protected_file` field type (extends core File) with a per-file **Protected** checkbox.
Protected files are visible to all but only downloadable by users with the `download protected file`
permission; the gate is enforced server-side in `hook_file_download()`. Field is locked to the
`private://` scheme. No global config page (`configure` null). Depends on core `field` + `file`.

- **Field type, widget, formatter settings, private-scheme requirement, media source** →
  [configure/field.md](configure/field.md)
- **How the download gate is enforced (`hook_file_download`) and the access-alter event** →
  [api/access.md](api/access.md)

Key facts:
- Plugins: field type `protected_file`, widget `protected_file_widget`, formatter `protected_file_formatter`,
  media source `protected_file`. No plugin *types* defined.
- Permission: `download protected file` (grant to the roles allowed to download). Not `restrict access`.
- Field storage is forced to `private://`; public scheme is rejected (`validateUriScheme`).
- Protection flag stored per file item in the `protected_file` column (0/1).
- Event `protected_file.check_access` (`ProtectedFileAccessEvent`) lets other modules alter each download.
