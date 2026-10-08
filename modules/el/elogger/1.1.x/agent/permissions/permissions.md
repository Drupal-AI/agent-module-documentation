# Permissions & entity access

Defined in `elogger.permissions.yml`:

| Permission | Grants |
|------------|--------|
| `administer event log entity` | Reach `/admin/structure/elog` (entity settings / field UI base route). Also the entity `admin_permission`. |
| `view event log entity` | View an `elog` entity (`entity.elog.canonical`) and the log listing rows. |
| `delete event log entity` | Delete an `elog` entity (`entity.elog.delete_form`). |
| `administer elogger configurations` | Reach the three config forms under `/admin/config/system/elogger` (filters, log-messages, settings). |

All four are non-restricted (no `restrict access: true`).

## Entity access handler

`Drupal\elogger\Access\EloggerAccessControlHandler` (the `elog` entity's access handler):

| Operation | Result |
|-----------|--------|
| `view` | Allowed if the account has `view event log entity`. |
| `delete` | Allowed if the account has `delete event log entity`. |
| `edit` | **Always forbidden** — log entries cannot be edited. |
| create | **Always forbidden** (`checkCreateAccess`) — entries are only created programmatically via the service, which bypasses this handler. |

Routes wire these via `_entity_access: elog.view` / `elog.delete`. The settings route
`/admin/structure/elog` is gated by `administer event log entity`; the three config routes by
`administer elogger configurations`.
