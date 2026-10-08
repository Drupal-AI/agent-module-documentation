<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Meeting API (meeting_api) — agent index

A **framework** module. It models a meeting as a revisionable **content entity** and delegates the
actual conferencing technology to a pluggable **backend plugin**. Version **1.0.0-alpha3** (alpha —
treat the API as unsettled). Core `^10 || ^11`. Depends on `datetime_range_timezone` and the
`league/period` PHP library.

The shipped code contains **no external-provider integration and no stored credentials**: the only
bundled backend is `meeting_api_manual`, which stores one URL per meeting and returns it. A real
Zoom/Teams/Jitsi/BigBlueButton backend is expected to be a separate module implementing
`BackendInterface`.

## The model in one pass

- `meeting_api_server` — **config entity**. A named endpoint bound to exactly one backend plugin;
  holds `backend` (plugin id) + `backend_config` (plugin config, e.g. secrets for a real provider).
- `meeting_api_meeting_type` — **config bundle entity**. A bundle of the meeting content entity that
  points at one server (`server_id`). "Webinar", "Consultation", etc.
- `meeting_api_meeting` — **content entity** (revisionable, owned, translatable label). Fields:
  `label`, `status`, `uid`, `created`, `changed`, `datetime` (daterange_timezone), `max_attendees`,
  `backend_settings` (opaque `map`, rendered by the `meeting_api_backend_settings_widget`).
- `meeting_api_backend` — **plugin type** (`Plugin/MeetingApiBackend`, `#[Backend]`,
  `BackendInterface`, `BackendPluginManager`). Each backend returns a join URL.
- `MeetingManager` (`Drupal\meeting_api\MeetingManagerInterface`) — **service**, the uniform entry
  point: `joinMeeting($meeting, $attendee): string`.

## Read next

- **Entity types (server, meeting type, meeting) — fields, config export, locked-backend rule** →
  [entities/index.md](entities/index.md)
- **The backend plugin type + the MeetingManager join API + writing a provider backend** →
  [plugins/backends.md](plugins/backends.md)
- **Submodules: `meeting_api_manual` and `meeting_api_scheduler`** →
  [submodules/index.md](submodules/index.md)

## Access model — read this before exposing anything

The README states the module "provides API features but **does not implement any permission
logic**." In practice that means:

- Every entity type is gated only by its `admin_permission`:
  `administer meeting_api_server`, `administer meeting_api_meeting types` (`restrict access: true`),
  `administer meeting_api_meeting entities`. There is **no** custom access handler, so viewing,
  creating, editing and deleting meetings all require the broad admin permission — there is no
  per-user "own meetings" or "join" permission.
- The meeting canonical route redirects to the **edit form** (`MeetingHtmlRouteProvider`), so there
  is no public "view a meeting" page by default.
- `backend_settings` (which holds the join URL / room id / passcode for a meeting) is **not** on the
  view display (`setDisplayConfigurable('view', FALSE)`), so it is not rendered on entity pages.
- If you build a public join flow, YOU must add the access checks and treat a returned join URL as a
  capability. If you write a backend that talks to a provider API, keep its credentials in
  `backend_config` behind a Key entity / environment variable — the framework does not do this for
  you.

## No settings form / no drush

`configure` is null. Admin lives at the three entity collection routes
(`/admin/config/services/meeting-api-server`, `/admin/structure/meeting_api_meeting_types`,
`/admin/content/meeting`). No hooks, no drush commands. Provides config schema and two bundled
system actions (save/delete meetings).
