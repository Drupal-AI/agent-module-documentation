<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules: meeting_api_manual and meeting_api_scheduler

Both live under `modules/` in the project and depend on `meeting_api`.

## meeting_api_manual — "Manual URL" backend

The only backend that ships with the project, and the reference implementation of the plugin type.

- `src/Plugin/MeetingApiBackend/Manual.php` — `#[Backend(id: 'manual', label: 'Manual URL')]`,
  extends `BackendPluginBase`. Declares one plugin form: `meeting` →
  `ManualMeetingConfigurationForm`.
- `defaultConfiguration()` is empty. `joinMeeting()` simply returns `$meeting->getSettings()['url']`
  — the URL an editor stored on the meeting. No external call, no credentials.
- `src/PluginForm/ManualMeetingConfigurationForm.php` — adds a required `#type => url` field
  ("Meeting URL") to the meeting form; the value is saved into the meeting's `backend_settings`
  map under `url`.

Use it for meetings whose join link is known ahead of time (a persistent room, a manually created
Zoom/Meet link). This is the "paste a URL" case most meeting systems omit.

## meeting_api_scheduler — availability & booking layer

Optional. Adds capacity/availability logic and a calendar UI on top of servers. **Requires the
FullCalendar JS library** (`fullcalendar/fullcalendar` 6.1.19); `hook_requirements()` errors at
runtime if the library is not found. Depends on `league/period` (already required by the parent).

### New plugin type: `meeting_api_time_constraint`

- Discovery `Plugin/MeetingApiTimeConstraint`; attribute
  `Drupal\meeting_api_scheduler\Attribute\TimeConstraint`; interface `TimeConstraintPluginInterface`;
  base `TimeConstraintPluginBase`; manager `TimeConstraintPluginManager` (alter
  `meeting_api_time_constraint_info`).
- A constraint plugin's `collect(MeetingRequest): League\Period\Sequence` returns the busy/blocked
  periods it wants to impose.
- Ships one plugin: **`server_capacity`** (`Plugin/MeetingApiTimeConstraint/ServerCapacity.php`).
  Config `users_limit`. It walks capacity "slots" (meeting attendees + soft reservations) sorted by
  time, accumulates concurrent load, and emits blocked `Period`s wherever load would exceed
  `users_limit - requested attendees`. If the request alone already exceeds the limit, the whole
  window is blocked.

### New config entity: `meeting_api_time_constraint`

`src/Entity/TimeConstraint.php` — `@ConfigEntityType`, `admin_permission:
"administer meeting_api_time_constraint"`. `config_export`: `id`, `label`, `description`,
`server_id`, `plugin_id`, `plugin_config`, `uuid`. Binds a constraint plugin to a server (hard
config dependency on the server). Routes under `/admin/config/services/meeting-api-time-constraint`.

### Services

- `TimeConstraintManager` (`Service/TimeConstraintManager.php`, implements
  `TimeConstraintCollectorInterface`) — aggregates all tagged
  `TimeConstraintCollectorInterface` collectors, clips their periods to the requested window and
  returns the union of busy intervals.
- `EntityTimeConstraintCollector`, `MeetingSlotCollector`, `SoftReservationSlotCollector`,
  `ServerCapacityManager` — collectors/helpers feeding the above.
- `SoftReservationManager` (`Service/SoftReservationManager.php`, `SoftReservationManagerInterface`)
  — create/remove/query **soft reservations**: temporary capacity holds while a user fills in a
  booking form. Stored in DB table `meeting_api_scheduler_soft_reservations` (see below) keyed by
  `(uuid, server_id, user_id)`, each with start/end/attendees/expiration. Uses parameterized
  query-builder `merge`/`delete`/`select` (no raw SQL). Negative TTL is rejected.
- `TimeslotSuggester` (`TimeslotSuggesterInterface`) — proposes an available slot near a desired
  timeframe.

### Cron & storage

- `Hook/CronHooks.php` (`#[Hook('cron')]`) deletes soft reservations whose `expiration` is in the
  past — reservations self-expire.
- `meeting_api_scheduler.install` defines the `meeting_api_scheduler_soft_reservations` table and the
  FullCalendar `hook_requirements()` check.

### Render element + events endpoint

- `Element/PeriodSchedule.php` (`#[RenderElement('period_schedule')]`) — a FullCalendar-backed widget
  showing busy periods for a server. Its `#cache['max-age']` is 0 (data is highly dynamic); the
  README warns this does not guarantee freshness for anonymous users behind a page cache — add your
  own invalidation if you expose it to anonymous users.
- `Controller/PeriodScheduleController::getEvents` at
  `/meeting-api-scheduler/events/{server}/{settings_key}` (GET, `no_cache: TRUE`). Returns busy
  slots (and an optional suggested slot) as JSON for the calendar. Gated by permission
  **`view any meeting_api server schedule`**, and the `{settings_key}` is verified with an HMAC
  (`Crypt::hmacBase64` over the serialized settings + server id, keyed by the site hash salt,
  compared with `hash_equals`) — a caller cannot forge or tamper the settings blob. Enforces
  required `start`/`end`/`timeZone` query params, a max one-week window, and ATOM date parsing.

### Permissions added

- `administer meeting_api_time_constraint`
- `view any meeting_api server schedule` (gates the events JSON endpoint)
