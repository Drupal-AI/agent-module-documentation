# BAT Unit — permissions

Static permissions (`bat_unit.permissions.yml`):

| Permission | Restricted | Gates |
|---|---|---|
| `administer bat_unit_bundle entities` | no | Add/edit unit bundles and their fields. |
| `administer bat_type_bundle entities` | no | Add/edit type bundles and their fields. |
| `view any bat_unit unpublished entity` | no | View any unpublished unit. |
| `view own bat_unit unpublished entities` | no | View own unpublished units. |
| `view any bat_unit_type unpublished entity` | no | View any unpublished type. |
| `view own bat_unit_type unpublished entities` | no | View own unpublished types. |

Dynamic permissions (`UnitPermissions::permissions`) call `bat_entity_access_permissions()` for both
`bat_unit` and `bat_unit_type`, generating the standard BAT scheme for each:

- `bypass <type> entities access` *(restricted)*
- `create <type> entities`, `view own …`, `view any … entity` *(restricted)*, `update own …`,
  `update any … entity` *(restricted)*, `delete own …`, `delete any … entity` *(restricted)*
- the same set **per bundle** (`… of bundle <b>`; `any` variants restricted).

Bulk delete / set-state routes require the restricted `bypass bat_unit entities access`. See the base
module's `agent/api/framework.md` (`modules/ba/bat/11.0.x/agent/api/framework.md`) for the runtime
access logic these permissions feed.
