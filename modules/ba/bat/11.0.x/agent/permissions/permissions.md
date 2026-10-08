# BAT base permissions

Defined in `bat.permissions.yml` plus the `TypeGroupPermissions::permissions` callback.

## Static permissions

| Permission | Restricted | Gates |
|---|---|---|
| `configure bat settings` | no | The `DateForm` (`/admin/bat/config/date`) and other BAT settings forms. |
| `administer bat_type_group_bundle entities` | no | Add/edit/delete type-group bundles and their fields. |
| `view any bat_type_group unpublished entity` | no | View any unpublished type group. |
| `view own bat_type_group unpublished entities` | no | View own unpublished type groups. |

## Generated `bat_type_group` permissions (`TypeGroupPermissions`)

`TypeGroupPermissions::permissions()` calls `bat_entity_access_permissions('bat_type_group')`,
producing the standard BAT scheme for that entity type:

- `bypass bat_type_group entities access` *(restricted)*
- `create bat_type_group entities`, `view own …`, `view any … entity` *(restricted)*,
  `update own …`, `update any … entity` *(restricted)*, `delete own …`, `delete any … entity` *(restricted)*
- the same set per `bat_type_group_bundle` bundle (`… of bundle <b>`, `any` variants restricted).

See [../api/framework.md](../api/framework.md) for the exact generator and the runtime access logic.
The functional submodules (`bat_unit`, `bat_event`, `bat_booking`, `bat_event_series`) reuse the same
generator for their own entity types — see each submodule's permissions doc.
