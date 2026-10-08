<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Decoupled JSON Log adds a `log_json` content entity so a decoupled or mobile front end can record its own errors in Drupal instead of a paid third-party service.

---

Clients create log entries by POSTing to JSON:API or REST (`log_json--<bundle>`, default bundle `error`), attaching a stringified error plus device info in a JSON field. A route subscriber (`DecoupledJsonLogLimitingRouteSubscriber`) deliberately removes the JSON:API PATCH and DELETE routes and locks GET behind an admin permission, so entries can be written but not listed, edited, or deleted through the API — managing logs is an admin-only, in-Drupal task. A `RateLimitPerUser` validation constraint caps how many logs each account (and anonymous) may create per day (defaults: 500 anonymous, 50 per authenticated user) to stop a buggy front end from self-DDoSing the site.

Operationally you grant the `create log_json` permission to the roles that should log, confirm the rate limits at `/admin/config/decoupled_json_log`, and optionally add extra log-type bundles at `/admin/structure/log_json_types`. Note the create endpoint is intended to be reachable by whichever roles you grant (often anonymous, by design) and still requires a CSRF token for cookie-authenticated writes.

---
- Collect front-end JavaScript errors from an Ionic/React/Vue app into Drupal.
- POST a stringified `Error` plus device info via JSON:API.
- Rate-limit anonymous log creation to a safe daily ceiling.
- Rate-limit authenticated users' log creation independently.
- Grant only the `create log_json` permission to trusted front-end roles.
- Add custom log-type bundles beyond the default `error` bundle.
- Prevent listing/editing/deleting logs over the API by design.
- Review collected logs inside Drupal as admin-only entities.
- Tune the per-user daily limit on the settings form.
- Anonymize a departing user's logs on account cancel (reassign).
- Delete a user's logs automatically when the account is deleted.
- Store arbitrary structured device metadata in the JSON field.
- Avoid third-party logging SaaS and keep user data first-party.
- Use JSON:API resource `log_json--error` from the front end.
- Require a CSRF token for browser-session POSTs.
- Cap runaway logging from a buggy deploy to protect the DB.
- Theme individual log entries via the `log_json` template if surfaced.
- Export/inspect logs through Drupal admin views you build.
