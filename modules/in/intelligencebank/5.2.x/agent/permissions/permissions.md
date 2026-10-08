# Permissions

Defined in `ib_dam.permissions.yml`. The parent module declares a single permission.

| Permission | Machine name | Grants |
|---|---|---|
| Administer IntelligenceBank configuration | `administer intelligencebank configuration` | Access the global settings form (`/admin/config/services/ib_dam`) and the submodule config forms (`ib_dam_media` media mapping at `/admin/config/services/ib_dam/media`). Also unlocks the iframe app's debug panel when `debug` is on. This is an admin/"restrict me" permission. |

Notes:
- The submodules do **not** define their own permissions. `ib_dam_media`'s two config forms reuse
  this same permission; its asset-browser form route (`/ib-dam-browser`) is instead gated at runtime
  by the core Media Library signed-state request (see the submodule's `api/browser-and-source.md`).
- `MediaLibraryIbDamBrowserForm::ADMIN_PERMISSION` references this string to decide whether to show
  the debug output to the current user.
