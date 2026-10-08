# Permissions

Defined in `media_library_importer.permissions.yml` (neither is marked `restrict access: true`).

| Permission | Gates |
|---|---|
| `Configure media library importer` | The configuration form (`/admin/config/media/media-library-importer`) — sets the **import folder** and all other settings. |
| `Import files into media library` | The import form (`/admin/config/media/media-library-importer/import`) — runs an import over the currently configured folder. |

Scoping:
- "Configure media library importer" lets the holder set `import_folder`.
- "Import files into media library" lets the holder scan that path and pull matching files into Media (and, by
  default, copy them into the public files directory).

Grant both only to trusted administrators. Because neither is `restrict access: true`, they appear as ordinary
permissions on the roles form — do not hand them to content-editor roles expecting them to be limited to the
media library.
