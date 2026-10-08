<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GCal Entity — setup

## 1. Global settings — `/admin/config/gcal_entity/config` (`gcal_entity.config`)
Permission: **`administer gcal entity entities`** (`restrict access: true`). Set:
- **Google API key** — a Calendar-API-enabled key. Stored per `api_storage_key`:
  `config` (default, in `gcal_entity.settings:googleapi`) **or** `state` (DB, not exported).
  The key is stored **in plaintext** — there is no Key-module integration; prefer `state` and keep
  config exports private.
- **start / end** date strings, **maxevents**, **timezone**, **date/time formats**,
  **cachetime** (seconds; default 300, `0` = no cache — not recommended), link texts, no-events text.
  Validated by `GcalSettingsService` (timezone must be a real identifier, dates must parse, etc.).

## 2. Create a calendar
**Structure/Content → GCal Entity → Add GCal entity.** Enter the calendar's **ID** (email-format address,
e.g. `xxx@group.calendar.google.com`). Publish it. Reference it from a content type with an
entity-reference field to embed it.

## 3. How it fetches (no config needed)
`gcal_entity.google_processor::load_google_calendar($calendar_id)` builds a `Google\Client`
(`setDeveloperKey`) and calls `events->listEvents($calendar_id, $optParams)` with the configured range,
maxResults, timezone. TLS is handled/verified by the Google client library. Events render through
overridable Twig templates (copy them into your theme to customise).

## Security recap
Official Google client (TLS verified, no disabled cert checks); the only route is this admin form; calendar
IDs come from admin-created entities, not request input; event descriptions are `Xss::filter`ed. The only
caveat is the plaintext API-key storage — treat it as a secret.
