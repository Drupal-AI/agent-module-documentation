<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Google Analytics Counter fetches aggregated page-view counts from Google Analytics (GA4) and stores them on a `page_views` base field on nodes so Views can sort, filter and display content by popularity.

---

The module registers a `page_views` integer base field on the node entity (stored in `node_field_data`) via `hook_entity_base_field_info`, and on each cron run calls its `easy_google_analytics_counter.connection` service to query the Google Analytics Data API (GA4) for the most-viewed page paths. It authenticates with a Google service-account JSON key (a filesystem path entered in config, or a key file uploaded through the admin form) that it exposes to the Google client library through the `GOOGLE_APPLICATION_CREDENTIALS` environment variable. Returned `pagePath` values are resolved back to node ids through the path alias manager and written into `page_views`, with duplicate aliases for the same node summed. Configuration lives in the `easy_google_analytics_counter.admin` config object, edited at `/admin/config/easy_google_analytics_counter/admin` (permission `administer site configuration`). Two hooks — `hook_easy_google_analytics_counter_query_alter` and `hook_easy_google_analytics_counter_update_node_page_views` — let other modules alter the GA query and react to updated counts. An optional `popular_articles` view ships as a ready-made "most viewed articles" listing.

---

- Show a "Most viewed" or "Popular content" block by adding a Views sort on the `page_views` field.
- Build a "Top 10 articles this week" page by setting the date range to 1 week and sorting nodes by `page_views` descending.
- Filter a content listing to only nodes above a popularity threshold (e.g. `page_views > 100`).
- Display the raw page-view count as a field on teasers or full node displays via Views.
- Enable the shipped `popular_articles` view (`/popular-articles`) as an out-of-the-box popular-articles listing.
- Replace a locally maintained hit counter with counts sourced from Google Analytics, offloading aggregation to Google.
- Populate a homepage "Trending now" section driven by real GA traffic data.
- Sort a taxonomy-term or category listing by how much traffic each article received.
- Feed popularity data into a related-content or recommendation block that orders by `page_views`.
- Schedule refreshes on Drupal's built-in cron by leaving "Independent cron" unchecked.
- Drive refreshes from an external system cron by enabling "Independent cron" and calling `_easy_google_analytics_counter_independent_cron()`.
- Choose how far back to aggregate (1 day up to 2 years, or "since launch") using the date-range setting.
- Cap how many rows are fetched from GA per request (10–100000) via the "Number of items" setting.
- Aggregate on a dimension other than page path by entering an alternate GA dimension in "Sort dimension".
- Add extra GA dimensions or otherwise modify the report query with `hook_easy_google_analytics_counter_query_alter()`.
- React to freshly updated counts (e.g. push to search index or external cache) with `hook_easy_google_analytics_counter_update_node_page_views()`.
- Export the fetched GA path-to-alias mapping to `public://ga_alias_file.csv` by enabling debug mode when troubleshooting path matching.
- Use the invalidated `easy_google_analytics_counter_page_views` cache tag to keep popularity listings fresh after each update.
- Point the module at a specific GA4 property by entering its numeric property id in the "View ID" field.
- Run on Drupal 9, 10, or 11 sites needing GA4-sourced popularity data.
- Combine the `page_views` field with other Views filters (content type, published status) to build per-section popularity pages.
- Query a single page's views on demand by passing a page path to the connection service's `request()` method.
