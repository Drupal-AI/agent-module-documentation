<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Decoupled JSON Log adds a `log_json` content entity so a decoupled or mobile front end can record its own errors in Drupal instead of a paid third-party service.

---

Clients create log entries by POSTing to JSON:API or REST (`log_json--<bundle>`, default bundle `error`), attaching a stringified error plus device info in two JSON fields (`log`, `device_info`). A route subscriber (`DecoupledJsonLogLimitingRouteSubscriber`) deliberately removes the JSON:API PATCH and DELETE routes and locks GET behind the `administer log_json types` permission, so entries can be written but not listed, edited, or deleted through the API — managing logs is an admin-only, in-Drupal task. A `RateLimitPerUser` validation constraint caps how many logs each account (and anonymous) may create per rolling interval, counted **per log type (bundle)** so one type never consumes another's allowance (defaults: 500 anonymous, 50 per authenticated user, 86400 s window). A `MaxPayloadSize` constraint rejects oversized entries (defaults 65536 bytes for `log`, 8192 for `device_info`) and logs the rejection to the module channel. Server-side `preSave` always stamps the current user (`uid`) and request time (`created`) on new entries so clients cannot spoof them to evade the rate limit. Each log type can override the rate-limit counts/interval on its type form, and a count of `0` rejects every client submission to that type.

Operationally you grant the `create log_json` permission to the roles that should log, confirm the rate limits and payload caps at `/admin/config/decoupled_json_log`, and optionally add extra log-type bundles at `/admin/structure/log_json_types`. The create endpoint is intended to be reachable by whichever roles you grant (often anonymous, by design) and still requires a CSRF token for cookie-authenticated writes.

---
- Collect front-end JavaScript errors from an Ionic/React/Vue app into Drupal.
- POST a stringified `Error` plus device info via JSON:API.
- Rate-limit anonymous log creation to a safe per-interval ceiling.
- Rate-limit authenticated users' log creation independently.
- Apply the rate limit separately per log type so one bundle can't starve another.
- Override the per-type rate-limit count/interval on a specific bundle.
- Set a log type's count to `0` to reject all client submissions to it (server-only type).
- Cap the byte size of the `log` field to protect the database.
- Cap the byte size of the `device_info` field independently.
- Grant only the `create log_json` permission to trusted front-end roles.
- Add custom log-type bundles beyond the default `error` bundle.
- Prevent listing/editing/deleting logs over the API by design.
- Review collected logs inside Drupal as admin-only entities.
- Tune the per-user daily limits and payload caps on the settings form.
- Anonymize a departing user's logs on account cancel (reassign).
- Delete a user's logs automatically when the account is deleted.
- Store arbitrary structured device metadata in the JSON field.
- Avoid third-party logging SaaS and keep user data first-party.
- Use JSON:API resource `log_json--error` from the front end.
- Require a CSRF token for browser-session POSTs.
- Cap runaway logging from a buggy deploy to protect the DB.
- Trigger emails/alerts on new logs via Views/ECA since logs are plain entities.
- Theme individual log entries via the `log_json` template if surfaced.
- Run on Drupal 11.3+ or Drupal 12 with PHP 8.5+.
