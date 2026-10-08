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
  file field's `file_extensions`. Edited at `/admin/content/path_file/settings`.
- `configure` route = `entity.path_file_entity.collection` (`/admin/content/path_file`) — the admin
  UI now lives under **Content**, not Structure.
- Admin permission: `administer path file entity entities`. Install grants
  `view published path file entity entities` to anonymous + authenticated.
- Core requirement: **`^11.3 || ^12`** (Drupal 11.3+/12 only).

## Diff 2.1.x → 2.2.x

- **Core support narrowed**: `^8.8 || ^9 || ^10 || ^11` → **`^11.3 || ^12`** (Drupal 8/9/10 dropped).
- **Admin UI relocated**: the collection, add/edit/delete, and settings routes moved from
  `/admin/structure/path_file_entity…` to **`/admin/content/path_file…`**; the menu link now sits
  under *Content* instead of *Structure*.
- **Download controller hardened for caching**: `PathFileController::file()` now returns
  `NotFoundHttpException` when the fid is empty, the file entity is missing, or `realpath()` fails /
  the file is absent on disk, and it adds an `X-Drupal-Cache-Tags` header (merged path_file + file
  cache tags) plus a `Last-Modified` header (from the entity changed time) for HTTP conditional
  requests.
- **Owner field**: `user_id` is now a first-class entity key (`owner`), populated via
  `EntityOwnerTrait::getDefaultEntityOwner` (update hook `10003` backfills existing rows to uid 1).
- **Required fields tightened**: `name`, `path`, and `fid` are marked required; update hooks
  `10004`/`10005` set a default name (`[unnamed]`) for null rows and realign the storage definitions.
- **Settings form validation**: `allowed_extensions` input is validated to letters/numbers/spaces only.
