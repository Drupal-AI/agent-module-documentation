<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `GoogleAnalyticsReportsApiFeed` service

Class `Drupal\google_analytics_reports_api\GoogleAnalyticsReportsApiFeed` — a proxy around
Google's `BetaAnalyticsDataClient` (library `google/analytics-data`) that authenticates from the
stored credentials and caches query results.

## Key members

| Member | Purpose |
|---|---|
| `static service(array $config = [])` | Build and return an authenticated feed from `google_analytics_reports_api.settings` (or the passed `$config`, used by the settings form to validate a just-uploaded key). Returns the feed, or `FALSE` if it cannot authenticate. |
| `isAuthenticated()` | `TRUE` when a Google client was created (`!empty($this->client)`). |
| `__call($func, $params)` | Magic proxy: forwards `$func` to the underlying `BetaAnalyticsDataClient`, caching the result in Drupal's cache for `cache_length` seconds (respects Google's API quota). Sets `$this->fromCache`. |
| `$property` | The configured GA4 property id. |
| `$fromCache` | `TRUE` if the last result came from cache. |

## Typical use

```php
use Drupal\google_analytics_reports_api\GoogleAnalyticsReportsApiFeed;

$feed = GoogleAnalyticsReportsApiFeed::service();
if ($feed && $feed->isAuthenticated()) {
  // Call a BetaAnalyticsDataClient method via the caching proxy, e.g. runReport(...).
  $response = $feed->runReport($request);
}
```

The parent `google_analytics_reports` module's Views query plugin and field import use this
service; you can call it from custom code to run GA4 reports without handling OAuth/service-
account auth yourself. Results only return real data with valid credentials and a reachable GA4
property. Errors from the Google client are caught and surfaced as messages, returning `FALSE`.
