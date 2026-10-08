<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Communico Plus integrates the Communico events platform (used by libraries) with Drupal. It authenticates to the Communico v3 REST API with a key/secret (OAuth client-credentials, Basic auth for the token request), pulls events, and creates/updates an `event_page` node type it installs (with a full set of `field_communico_*` fields: event id, dates, image, type, age group, location, registration URL, etc.). A block renders an events feed, and controller routes render a single event page and a reservation page.

---

Import is queue-driven (depends on `queue_ui`): `CommunicoEventSyncQueue` creates/updates event nodes and `CommunicoEventDeleteQueue` removes stale ones. The `ConnectorService` handles token caching in state, event/feed/reservation/room/location lookups, and caches feed data for 5 minutes. Config (API url, link url, access key, secret key) is set at `/admin/config/communico_plus/api`; a second form at `/admin/config/communico_plus/import` triggers imports. Both admin forms require the `administer communico_plus` permission.

Setup: enable the module (and queue_ui), enter the Communico API URL and key/secret, run an import, and place the events block. The public routes `/event/{eventId}` and `/registration/{registrationId}` are gated by `access content`.

---

- Enter Communico API URL, link URL, access key and secret
- Run an events import from `/admin/config/communico_plus/import`
- Process the import queue via cron or queue_ui
- Create/update `event_page` nodes from Communico events
- Delete stale event nodes via the delete queue
- Place the Communico events block
- Render a single event at `/event/{eventId}`
- Render a reservation at `/registration/{registrationId}`
- Fetch an events feed filtered by date/type/age/location
- Look up library locations, rooms, event types, age groups
- Cache feed data to reduce API calls
- Map Communico fields to the installed event fields
- Theme the event page and reservation templates
- Restrict configuration to the `administer communico_plus` permission
- Refresh the auth token automatically on expiry
- Display event images pulled from Communico
- Show event expiry/finished messaging
- Build a library events calendar from imported nodes
