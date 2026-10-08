<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Calendar Entity (gcal_entity) — agent index

**Fetches Google Calendar events via the Calendar API and displays them as a Drupal content entity/agenda.**

- **Version:** 2.0.x (2.0.6)
- **Core:** ^10.1 || ^11
- **Composer:** requires `google/apiclient` (`Google\Client`).
- **Route:** `gcal_entity.config` → `/admin/config/gcal_entity/config` (permission `administer gcal entity entities`, `restrict access: true`).
- **Content entity:** `gcal_entity` with add/edit/delete/publish permissions; entity-reference friendly; translation + Views data handlers.
- **Services:** `gcal_entity.google_processor` (API calls + event parsing), `gcal_entity.settings` (config/state, API-key storage).

**Security:** uses the official Google client → **TLS verified by default** (no `verify=>false`/`CURLOPT` disabling, no hand-rolled HTTP). Only admin route is the config form; calendar ID comes from the admin-created entity, **not request input** — no anonymous arbitrary-calendar endpoint. Event description sanitised via `Xss::filter`+`_filter_autop`, output Twig-escaped. **Note:** the Google API key is stored in **plaintext** in config (`gcal_entity.settings:googleapi`) or state — no Key/secrets integration; keep it out of committed config exports.

See [configure/setup.md](configure/setup.md).
