<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Aggregates status summaries from multiple Drupal sites (via HMAC-signed requests to their Multisite Status Report endpoints) onto one admin dashboard.

---

Multisite Status Dashboard pulls the status summary from several remote Drupal sites — each running the companion Multisite Status Report module — and shows them together on one admin dashboard at `/admin/reports/multisite-status`.

Each remote site is a `monitored_site` config entity (label, base URL, key ID, shared secret, enabled) managed at `/admin/config/services/multisite-status-dashboard/sites` under the restricted `administer multisite status dashboard` permission. `StatusFetcher` requests `<base_url>/multisite-status-report/summary` with HMAC-SHA256 signed headers (`X-MSR-Key`, `X-MSR-Timestamp`, `X-MSR-Nonce`, `X-MSR-Signature`) — the shared secret is used only to compute the signature locally and is never sent over the wire; the outbound HTTP client uses default TLS verification. Results are stored via `StatusAggregator` (keyvalue) and can be refreshed either through a queue worker (`SiteStatusFetchWorker`) on cron or on demand via `POST /admin/reports/multisite-status/refresh` (CSRF-protected). The dashboard renders severity, reachability and summary per site; it does not display the stored secrets. Viewing the dashboard needs `view multisite status dashboard`.

Typical setup: add each monitored site with its key ID and secret, then view or refresh the aggregated dashboard.
---
- Aggregate status from many Drupal sites on one screen.
- Add a monitored site with its base URL and credentials.
- Sign status requests with HMAC-SHA256 (secret never sent).
- Refresh a site's status on demand (CSRF-protected).
- Refresh statuses in the background via a queue worker on cron.
- Show per-site severity and reachability.
- Enable or disable individual monitored sites.
- Restrict site management to administrators.
- Grant view-only dashboard access to operators.
- Store results in keyvalue for fast rendering.
- Handle unreachable sites gracefully with error rows.
- Verify TLS on outbound requests by default.
- Monitor overall health across an estate of sites.
- Track the last-fetched time per site.
- Integrate with the Multisite Status Report endpoints.
