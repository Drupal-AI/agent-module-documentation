<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Analytics Reports API is the credential-holding, API-access layer for the Google Analytics Reports project. It stores a GA4 Property ID plus a service-account credential JSON key, wraps Google's Analytics Data API client, and exposes a cached feed service that other modules (notably Google Analytics Reports) use to query GA4 data.

---

This submodule owns the settings form at `/admin/config/services/google-analytics-reports-api` (route `google_analytics_reports_api.settings`), where an administrator enters the numeric **Property ID**, uploads the **Credential JSON** service-account key (stored as a private managed file), and chooses a **Query cache** duration. Those values live in config `google_analytics_reports_api.settings` (`property`, `json`, `cache_length`; the shipped install file also contains legacy `client_id`/`client_secret`/`default_page`/`profile_id` keys from the pre-GA4 era). The heart of the module is `GoogleAnalyticsReportsApiFeed`, a proxy around Google's `BetaAnalyticsDataClient` (from the `google/analytics-data` library): its static `service()` builds an authenticated feed from the stored credentials, `isAuthenticated()` reports whether a client was created, and its `__call()` magic method forwards report calls to the Google client while caching results in Drupal's cache for `cache_length` seconds to respect Google's API quota. It defines one permission (`administer google analytics reports api`) and adds no plugins, Views handlers, or report UI of its own — those belong to the parent module. It has no Drupal module dependencies (private-file support is needed for the credential upload). Because it talks to an external Google service, nothing returns real data until valid credentials and a reachable GA4 property are configured.

---

- Store a GA4 Property ID and service-account credential JSON for the whole GA Reports project.
- Provide a single authenticated feed service (`GoogleAnalyticsReportsApiFeed`) for querying GA4.
- Cache Google Analytics Data API responses to stay within Google's daily query quota.
- Configure the query cache length (1-6 days or 1-4 weeks) on the settings form.
- Check whether the site is authenticated with Google via `isAuthenticated()`.
- Upload the service-account key as a private file so it is not web-accessible.
- Let a custom module run GA4 report queries through the shared feed proxy.
- Centralise Google credentials so multiple report displays reuse one connection.
- Gate the credential settings form behind the `administer google analytics reports api` permission.
- Swap credentials by re-uploading a new JSON key and property id.
- Wrap Google's `BetaAnalyticsDataClient` without writing your own auth code.
- Reduce API cost by serving repeated report queries from Drupal cache.
- Serve as the dependency that the Google Analytics Reports (Views) module builds on.
- Validate credentials at save time (the form rejects an unauthenticated key).
- Read the configured property id from `google_analytics_reports_api.settings:property`.
- Adjust caching per environment (shorter cache in staging, longer in production).
- Support GA4's Analytics Data API v1beta rather than the deprecated Universal Analytics API.
- Provide programmatic GA access for dashboards, blocks, or custom reports.
- Keep the GA integration credentials in Drupal configuration + a private file, not in code.
- Enable other modules to detect GA availability before attempting a report.
