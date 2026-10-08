Statistics Counter extends the Statistics module by adding week, month and year node-view counters alongside core's day and total counters. Enable it and the counters become available to Views as fields, sorts, filters and arguments under the "Content statistics" group. There is no UI or configuration.

---

The core Statistics module records how many times each node is viewed, keeping a `daycount` (reset each cron run) and a `totalcount` in the `node_counter` table. Statistics Counter adds three more columns to that table — `weekcount`, `monthcount` and `yearcount` — and keeps them current. A kernel TERMINATE event subscriber increments all three by one every time a node page is rendered, but only when core Statistics' "Count content views" setting (`statistics.settings:count_content_views`) is on, exactly like core's own counting. `hook_cron` resets each rolling counter when its calendar period rolls over: `weekcount` clears at the start of a new ISO week, `monthcount` at a new month, `yearcount` at a new year, so cron must run at least as often as you want the rolling windows to refresh. On enable the three new columns are seeded from the existing `daycount` value.

The value the module delivers is Views integration: `statistics_counter.views.inc` registers "Views this week", "Views this month" and "Views this year" against the `node_counter` table via `hook_views_data_alter`, each usable as a click-sortable numeric field, a numeric filter, a numeric argument and a standard sort. Combined with core Statistics' own "Total views", "Views today" and "Most recent view", this lets you build "most popular this week/month/year" listings, blocks and feeds without writing any custom query. The module ships no permissions, no Drush commands, no config schema and no admin forms — it is purely a data extension plus Views metadata. Uninstalling drops the three columns again.

---

- Build a "Most popular this week" node listing by sorting a View descending on "Views this week".
- Build "Trending this month" and "Top of the year" blocks using the month and year sort fields.
- Show a node's weekly, monthly and yearly view counts as fields in a teaser or full-page View.
- Add a numeric filter "Views this week ≥ N" to surface only nodes above a popularity threshold.
- Use "Views this year" as a contextual filter (argument) to drive a popularity-ranked feed.
- Compare rolling windows side by side (week vs month vs year) in a single admin report View.
- Create an RSS or JSON feed of the top-viewed articles for the current month.
- Power a homepage "Popular right now" carousel from the weekly counter.
- Rank search or listing results by recent popularity rather than all-time totals.
- Drive an editorial dashboard that highlights content gaining views this week.
- Combine with core's "Total views" to show both lifetime and recent popularity in one table.
- Detect stale content by filtering for low monthly or yearly view counts.
- Feed a "related / also popular" block scoped to the current period.
- Export period-scoped view statistics via Views data export for reporting.
- Reset all rolling counters automatically on the calendar boundary through normal cron runs.
- Seed the new counters from the existing day count when first enabling the module.
- Track seasonal content performance by watching the yearly counter across a campaign.
- Give editors a "views this week" column in their content overview View.
- Sort a taxonomy-term page's node list by current-month popularity.
- Provide per-author popularity leaderboards scoped to the week or month.
- Surface the fastest-rising nodes by pairing a weekly-count sort with a recent-created filter.
- Cleanly remove the columns on uninstall so no orphaned schema remains.
