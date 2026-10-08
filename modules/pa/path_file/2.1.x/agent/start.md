# Path File — agent index

Provides one content entity type, **`path_file_entity`**, that stores an uploaded file plus an
editable URL alias and streams the file from that alias (`BinaryFileResponse`). Point of the
module: a **stable download URL** that survives replacing the file. No plugins, no hooks, no Drush.

- **Entity structure, base fields, the `/path-file/{id}` download controller, and creating a Path File in code** →
  [api/path-file-entity.md](api/path-file-entity.md)
- **Allowed file extensions setting + admin routes (collection / settings)** →
  [configure/settings.md](configure/settings.md)
- **The seven permissions and the default anon/authenticated grants** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config: `path_file.settings` → `allowed_extensions` (space-separated list) drives the `fid`
  file field's `file_extensions`. Edited at `/admin/structure/path_file_entity/settings`.
- `configure` route = `entity.path_file_entity.collection` (`/admin/structure/path_file_entity`).
- Admin permission: `administer path file entity entities`. Install grants
  `view published path file entity entities` to anonymous + authenticated.
