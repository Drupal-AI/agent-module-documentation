<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bizzabo API connector pulls events from the Bizzabo events API and renders them as a listing in Drupal.

---
Configuration forms at `/admin/config/eventapi/baseUrl` and `/admin/config/test_connection` (both `administer site configuration`) store the API base URL and a bearer `auth_key` in the `bizzabo_connector.baseurl` config object. `BizaboEventController::getDisplayEvents()` fetches the endpoint with a Guzzle client, paginates the `content` array and renders it through the `BizaboEventsDisplayPage` theme.

Security notes to be aware of: two routes are declared with `_access: "TRUE"` — `/bizabo/fetch/events` (`getDisplayEvents`) and `/admin/config/api/param` (`testConnection`) — so they are reachable anonymously; `getDisplayEvents` exposes the fetched Bizzabo event list to any visitor. The stored `auth_key` is a plain-text config value. Setup task: set the base URL and bearer key, run the test connection, then place/link the events listing.
---
- Set the Bizzabo API base URL at `/admin/config/eventapi/baseUrl`.
- Store the bearer `auth_key` for the API.
- Run the connection test at `/admin/config/test_connection`.
- Fetch upcoming events from Bizzabo.
- Display a paginated events listing.
- Link visitors to `/bizabo/fetch/events`.
- Theme the events page via `BizaboEventsDisplayPage`.
- Inspect available API params at `/admin/bizabo/fetch/events/params`.
- Map event start/end dates and venue to display rows.
- Restrict configuration to site administrators.
- Review which routes are anonymous before launch.
- Cache-tune the events listing (currently max-age 0).
- Mask API response params in the test view.
- Integrate an events calendar into a landing page.
- Show event city/state/timezone.
- Troubleshoot API auth via the test connection form.
