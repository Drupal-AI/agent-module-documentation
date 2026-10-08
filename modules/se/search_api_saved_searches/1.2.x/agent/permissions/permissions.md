# Permissions

Declared in `search_api_saved_searches.permissions.yml` (one static permission plus a callback).

| Permission | Provided by | Grants |
|---|---|---|
| `administer search_api_saved_searches` | static YAML | Full admin: manage saved-search types at `/admin/config/search/search-api-saved-searches`, and view/edit/delete any saved search (bypasses the owner/token check; admins also skip activation on create). Entity `admin_permission` for both entity types. |
| `use <type_id> search_api_saved_searches` | `Permissions::bySavedSearchType()` (permission callback) | Create and use saved searches of that one type. One permission is generated per `search_api_saved_search_type` (e.g. `use default search_api_saved_searches`). |

Notes:
- The per-type permission is required for every operation on a saved search of that bundle — the
  access handler `andIf`s it with the owner/token check (`checkBundleAccess()`), and the "Save
  search" block only appears to users who hold it (`SaveSearch::access()` via `createAccess`).
- Grant `use <type_id> search_api_saved_searches` to the **anonymous** role to let visitors save
  searches; the `email` plugin's activation flow (see [../configure/type.md](../configure/type.md))
  is what confirms an anonymous subscriber's address.
- Losing a `use ...` permission (or being blocked) deactivates a user's searches of that type via
  `hook_user_update` (`notify_interval` set to `-1`); cron also re-checks the owner still holds the
  permission before notifying.
