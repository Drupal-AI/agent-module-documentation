# Access by Reference — permissions

Defined in `access_by_ref.permissions.yml`.

| Permission | `restrict access` | Gates |
|---|---|---|
| `access node by reference` | **false** | Whether the reference-based access rules apply *to the holder's roles*. If unchecked for a role, that role is unaffected (neutral). This is the runtime toggle — grant it to the (lower-trust) roles that should gain reference-based access. |
| `administer access_by_ref settings` | **true** | Full control of the `abrconfig` rules UI (`/admin/config/content/access_by_ref` and all add/edit/delete routes). Trusted admin permission. |

Notes:
- All four routing entries (collection, add, edit, delete) require `administer access_by_ref settings`.
- `access node by reference` is intentionally non-restricted (meant to be granted broadly to
  authenticated roles); the actual grant then depends on matching a reference.
- The `Abrconfig` entity annotation references `admin_permission = "administer
  access_by_ref_settings settings"`, which does not match the defined permission string; route
  access (the real gate) uses the correct `administer access_by_ref settings`.
