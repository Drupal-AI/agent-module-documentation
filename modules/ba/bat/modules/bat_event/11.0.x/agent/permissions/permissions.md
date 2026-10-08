# BAT Event — permissions

Static (`bat_event.permissions.yml`):

| Permission | Restricted | Gates |
|---|---|---|
| `administer bat_event_type entities` | no | Add/edit event types and their fields (also drives dynamic table creation). |
| `administer state entities` | no | Add/edit availability states. |

Dynamic permission callbacks generate the standard BAT scheme
(`bat_entity_access_permissions()`, see base `agent/api/framework.md`):

- `EventPermissions::permissions` → for `bat_event`: `bypass bat_event entities access` *(restricted)*,
  `create bat_event entities`, `view own/any`, `update own/any`, `delete own/any` (the `any` variants
  restricted), plus the per-`bat_event_type`-bundle set.
- `StatePermissions::permissions` → the same scheme for the `state` entity.

Note: the event **collection** route (`/admin/bat/events/event`) requires the restricted
`bypass bat_event entities access`, while individual event add/edit/delete use the per-bundle
`_entity_access` checks.
