<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Analytics injects analytics snippets and/or runs an internal visitor tracker with admin reports.

---

Simple Analytics does two things: it can inject third-party analytics markup (Google Analytics ID, Matomo/Piwik URI+ID, or custom script/noscript) into pages, and it can run its own internal tracker. The internal tracker posts visit data to `/simple_analytics/api/track` (an intentionally open, `_access: TRUE` endpoint) which stores a per-signature visit row and page-view rows via the Drupal DB API. Admin reports (today, live, visitor details, settings, history) live under `/admin/reports/simple_analytics` behind `simple_analytics view_*` permissions; settings are behind the restricted `simple_analytics admin` permission. Daily archiving aggregates and purges old rows. A `simple_analytics_event` example submodule shows the tracking event subscriber. Reports render stored values through `#theme => 'table'` (auto-escaped).

---

- Add a Google Analytics snippet site-wide.
- Add a Matomo/Piwik tracking snippet.
- Inject a custom analytics script/noscript.
- Run a built-in cookieless visitor tracker.
- Exclude admins/authenticated users from tracking.
- Exclude specific URLs from tracking.
- View today's visitors and page views.
- View a live visitor counter and block.
- Drill into a single visitor's details.
- View historical charts over N days.
- Archive yesterday's data automatically.
- Purge data older than a configured duration.
- Gate reports behind view permissions.
- Gate settings behind a restricted permission.
- Subscribe to tracking events (example submodule).
- Run on Drupal 8, 9 and 10.
