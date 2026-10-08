<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Analytics Reports API — agent index

Credential + API-access layer for the GA Reports project. Holds the GA4 Property ID and a
service-account credential JSON, and exposes a cached feed service wrapping Google's Analytics
Data API. No Drupal module dependencies (needs private-file support). External Google service.

- **Settings form + config keys (property, json, cache_length) and credential setup** →
  [configure/settings.md](configure/settings.md)
- **`GoogleAnalyticsReportsApiFeed` service (authenticate, query, cache)** →
  [api/feed-service.md](api/feed-service.md)

Key facts:
- Config: `google_analytics_reports_api.settings` → `property` (GA4 numeric property id,
  required), `json` (private managed-file id of the service-account key), `cache_length`
  (seconds, default `259200` = 3 days). Legacy install keys `client_id`, `client_secret`,
  `default_page`, `profile_id` also present but unused by the GA4 code.
- Route/config UI: `google_analytics_reports_api.settings` →
  `/admin/config/services/google-analytics-reports-api`.
- Permission: `administer google analytics reports api`.
- Service class `GoogleAnalyticsReportsApiFeed`: static `service()` builds an authenticated feed;
  `isAuthenticated()` = a client was created; `__call()` proxies to Google's
  `BetaAnalyticsDataClient` (library `google/analytics-data`) with per-query caching.
