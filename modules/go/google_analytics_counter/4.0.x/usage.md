<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Analytics Counter pulls page-view figures from the Google Analytics Data API (GA4) back into Drupal on cron and stores them per path and per node, so "most read" listings, counter fields, blocks, and tokens can be built from real analytics data rather than Drupal's own request counting.

---

Drupal's core Statistics module counts requests itself, which is inaccurate behind a CDN or page cache and adds a write to every page view. This module takes the opposite approach: Google Analytics already counts views accurately, so it fetches those numbers on cron and stores them locally. Authentication is GA4 service-account based — you enter a GA4 Property ID and the filesystem path to a Google service-account credentials.json on the Authentication form (`…/authentication`); there is no OAuth pop-up or callback. A settings form at `/admin/config/system/google-analytics-counter` holds the sync options (fetch interval, chunk size, cache length, date range, metric/dimension, and a pluggable "result processor" that maps GA rows onto nodes), a Custom field form adds an integer `field_google_analytics_counter` to chosen content types, and a dashboard reports what has been fetched and how much of the queue remains. During cron the module queues GA queries, writes cleaned path→pageview rows into its `google_analytics_counter` table, then sums each node's aliases into `google_analytics_counter_storage` and the node field. Counts are then available through the field, a "Google Analytics Counter" block, a `[gac]` text-filter token, and Views (base table `google_analytics_counter_storage`). A single permission, `administer google analytics counter`, gates every configuration screen. The module is deliberately lightweight — it does not embed tracking JavaScript (that is `google_analytics`'s job); it only reads the resulting data back.

---

- Show accurate page-view counts that survive page caching and CDNs.
- Build a "most read articles" block from real GA4 analytics data.
- Sort a Views listing by popularity using `pageview_total`.
- Replace core Statistics without losing view counts.
- Display a per-node view counter via the `field_google_analytics_counter` field.
- Drop a pageview count anywhere with the `[gac]` filter token.
- Place the "Google Analytics Counter" block to show the current page's count.
- Sync view data on cron rather than on every request.
- Choose exactly which content types carry a counter field.
- Monitor fetch progress and queue depth from the dashboard.
- Avoid a database write on every page view.
- Throttle fetching with a minimum cron interval to respect GA quotas.
- Limit processing to recently created nodes on large sites.
- Skip nodes newer than X days to avoid GA4's up-to-24h data lag.
- Point at any GA4 metric/dimension pair for custom counts.
- Aggregate views across a node's aliases, languages, and redirects.
- Add a custom result processor to map GA rows to nodes your own way.
- Alter the outgoing GA4 query from another module via the query-alter event.
- Cache GA responses for a configurable window to cut API calls.
- Feed a "recommended content" block with view totals.
- Rank search results by popularity using the stored counts.
- Give editors visibility of what is being read.
- Report on content performance inside Drupal.
- Clear the path/pageview table or the worker queue on demand from the settings form.
- Keep the tracking snippet in the google_analytics module where it belongs.
