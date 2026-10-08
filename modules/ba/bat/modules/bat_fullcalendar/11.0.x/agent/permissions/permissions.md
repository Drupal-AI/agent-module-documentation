# BAT Fullcalendar — permissions

`bat_fullcalendar.permissions.yml`:

| Permission | Restricted | Gates |
|---|---|---|
| `administer calendar events` | no | The settings form (`/admin/bat/config/fullcalendar`) and, in dependent modules, the calendar admin pages. |
| `view past event information` | no | Viewing event info in the past (notably via the event-reference field / `bat_calendar_reference`). |

Note: the actual in-calendar event create/update is not gated by these — the event-management modal
route uses `_event_management_access`, which defers to `bat_event`'s per-event
`create`/`update` access (see [api/calendar.md](../api/calendar.md)).
