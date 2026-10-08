<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Statistics logs how many times each node is viewed, keeping a per-node total count, a daily count, and a last-viewed timestamp. It was a Drupal core module through Drupal 10 and now ships as a contributed module for Drupal 10.3+/11.

---

When enabled and the `count_content_views` setting is turned on, Statistics records a view every time a node's full page is rendered. Counting happens client-side: `statistics_node_view()` attaches a small JS library that POSTs the node id to the module's `statistics.php` endpoint, which calls the storage backend's `recordView()` to increment the `node_counter` table (columns `totalcount`, `daycount`, `timestamp`). Read access to the numbers is gated by the `view post access counter` permission, which adds a "N views" link under nodes; the `administer statistics` permission gates the settings form at `/admin/config/system/statistics`. The module ships a "Popular content" block (`statistics_popular_block`) that lists the day's top, all-time top, and most recently viewed nodes, plus Views field plugins ("Content statistics: Total views / Today's views / Most recent view") and replacement tokens (`[node:total-count]`, `[node:day-count]`, `[node:last-view]`). All read/write access to the counts goes through the `statistics.storage.node` service (`StatisticsStorageInterface`), so the storage backend is swappable. A daily cron run resets the day counter and recomputes a popularity scale used to boost search ranking by view count.

---

- Count how many times each node (article, page, etc.) is viewed on the front end.
- Show a "N views" counter link beneath published content for users with the right permission.
- Display a "Popular content" block listing today's most-viewed, all-time most-viewed, and most recently viewed nodes.
- Configure how many items each of the three "Popular content" lists shows.
- Toggle view counting on or off site-wide with the `count_content_views` setting.
- Read a single node's total view count programmatically via the `statistics.storage.node` service.
- Fetch view counts for many nodes at once (`fetchViews()`) for a custom report.
- List the top N nodes by total views, today's views, or recency (`fetchAll()`).
- Record a view for a node from custom code (`recordView()`), e.g. for API-only or decoupled front ends.
- Delete stored view counts for a node when it is removed or reset (`deleteViews()`).
- Add "Total views", "Today's views" or "Most recent view" columns to a View of content.
- Sort or filter a View of nodes by popularity (view count).
- Insert per-node view counts into templates, emails, or labels using the statistics tokens.
- Boost search results ranking for frequently viewed content (Statistics search ranking factor).
- Build a "trending today" list from the day counter that automatically resets each day via cron.
- Swap the default database storage for a custom backend (Redis, external analytics) by overriding the `statistics.storage.node` service.
- Cache the displayed counters for a configurable interval with the `display_max_age` setting to reduce load.
- Seed or migrate historic view counts from a Drupal 6/7 site into `node_counter` via the bundled migrations.
- Report the highest total view count on the site (`maxTotalCount()`) for scaling or dashboards.
- Expose view counts to a decoupled/JSON front end by reading the storage service in a custom controller.
