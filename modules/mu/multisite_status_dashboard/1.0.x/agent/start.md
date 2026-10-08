<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multisite Status Dashboard (multisite_status_dashboard) — agent index

**Aggregates status summaries from multiple Drupal sites via HMAC-signed requests to their Multisite Status Report endpoints, onto one admin dashboard.**

- **Version:** 1.0.x (release 1.0.0-alpha3) — core `^10.1 || ^11 || ^12`
- **Dashboard:** `/admin/reports/multisite-status` + `POST /refresh` (CSRF-protected) — `view multisite status dashboard`
- **Sites:** `monitored_site` config entity at `/admin/config/services/multisite-status-dashboard/sites` — `administer multisite status dashboard` (restricted)
- **Services:** `StatusFetcher` (HMAC-SHA256 signed GET to `<base_url>/multisite-status-report/summary`; secret never transmitted; default TLS verify), `StatusAggregator` (keyvalue), queue worker `SiteStatusFetchWorker`
- **Security:** dashboard and refresh permission-gated; refresh is CSRF-protected; outbound requests use default TLS verification and HMAC signing. The dashboard does not render secrets.

See [configure/monitored-sites.md](configure/monitored-sites.md).
