<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & route access

## Permission

`fullcalendar.permissions.yml` defines one permission:

| Permission | Machine name | Gates |
|---|---|---|
| Update any FullCalendar event | `update any fullcalendar event` | Allows editing/moving events, **ignoring other permissions** (i.e. drag-and-drop reschedule any event regardless of normal entity edit access). |

Grant it:

```bash
drush role:perm:add editor 'update any fullcalendar event'
```

## AJAX route access

The two AJAX routes (`fullcalendar.routing.yml`) both require the core `access content`
permission:

- `fullcalendar.update` — `/fullcalendar/ajax/update/drop/{entity_type}/{entity}`
  (`UpdateController::drop`), `_format: json`. Persists a drag-and-drop date change; the
  `{entity}` is upcast via `type: entity:{entity_type}`.
- `fullcalendar.results` — `/fullcalendar/ajax/results/{view}/{display_id}`
  (`ResultsController::getResults`). Returns events for calendar navigation; `{view}` is
  upcast to a View entity.

Note the update route's config includes a commented-out custom access check
(`_access_fullcalendar_update`), so effective access is `access content` plus the controller's
own entity-access / `update any fullcalendar event` logic.
