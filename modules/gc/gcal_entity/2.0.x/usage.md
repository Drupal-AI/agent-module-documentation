<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Calendar Entity (GCal Entity) fetches events from a Google calendar via the Calendar API and displays them as a Drupal content entity in an agenda format.

---

You configure a site-wide Google **API key** and display options at `/admin/config/gcal_entity/config`
(gated by `administer gcal entity entities`, which is flagged `restrict access: true`), then create **GCal
Entity** content entities, each holding a calendar ID (an email-format address). On display, the
`gcal_entity.google_processor` service calls the Google Calendar API (official `google/apiclient`
`Google\Client` with `setDeveloperKey($google_key)`, `Google_Service_Calendar::events->listEvents`) using
the configured date range, max-results, timezone and cache time, and renders events through overridable
Twig templates. The entity can be referenced from content via an entity-reference field.

Security review: the module uses the official Google API client, so **TLS is verified by the client library
by default — there is no `verify => false`, disabled `CURLOPT_SSL_VERIFYPEER`, or hand-rolled HTTP**. There
is **no anonymous route that pulls arbitrary calendar data**: the only route is the admin config form; the
calendar ID is stored in the entity (admin-created), not taken from request input, and event display is the
intended public output of a published calendar (with configurable caching, default 300s). Event fields are
sanitised on render — the description is run through `Xss::filter` + `_filter_autop`, and output goes through
Twig auto-escaping. The one thing to note is that the **Google API key is stored in plaintext**, either in
config (`gcal_entity.settings:googleapi`) or in state (selectable via `api_storage_key`); there is no Key
module / secrets-manager integration, so the key can end up in exported config. Treat the key as a secret
(prefer the `state` storage option and keep config exports out of public repos). No unverified callbacks,
no raw SQL, no weak tokens.

---

- Show a Google calendar's events in an agenda list on a page.
- Create a GCal Entity holding a calendar ID (email format).
- Reference a calendar entity from a content type via entity reference.
- Configure a site-wide Google API key for calendar access.
- Set the event date range (start/end) to display.
- Cap the number of events fetched (maxevents).
- Set a display timezone for events.
- Tune cache time (default 300s) to balance freshness vs load.
- Customise date and time formats for event display.
- Set custom link text for event and hangout links.
- Override the agenda Twig templates in a theme.
- Show all-day events correctly (exclusive end-date handling).
- Display Google Meet / hangout links when present.
- List multiple calendars as separate entities.
- Store the API key in state instead of config (api_storage_key).
- Restrict calendar administration behind a restricted permission.
- Publish/unpublish individual calendar entities.
- Translate calendar entities (translation handler provided).
- Provide Views data for GCal entities.
- Set 'no events' placeholder text.
