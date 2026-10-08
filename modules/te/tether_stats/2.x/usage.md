<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tether Stats is a self-hosted site-statistics system that tracks page hits, link clicks and impressions in local Drupal tables, with built-in charts and a Views integration — no third-party analytics service.

---

Install the module (`composer require drupal/tether_stats`, then enable it) and go to **Configuration → System → Tether Stats** (`/admin/config/system/tether-stats`, permission **Administer Tether Stats**). Collection is **off by default**: tick **Activate Stat Data Collection** to start recording. A request subscriber maps each front-end page to a *stats element* (keyed by URL, by entity for node pages, or by a custom name) and the bundled JavaScript reports a "hit" back through an AJAX beacon; link clicks and impressions can be tracked by adding the `tether_stats-track-link` class and `data-*` identity attributes to markup, or via `TetherStatsManager::generateLink()`. Use the **Page Tracking Filter** to include or exclude pages by URL pattern (`%`/`#` wildcards) or route name (`*` wildcard), and the **User role Filter** to exclude roles such as administrators. **Derivatives** let you attach several independent counters to one entity or page. The **Overview** tab shows top pages plus combo and pie charts (rendered by a pluggable chart renderer — Google Charts by default) that can be iterated over time; grant **View Tether Stats Data** to let a role load that chart data. The stat tables (`tether_stats_element`, `tether_stats_activity_log`, `tether_stats_hour_count`, `tether_stats_impression_log`) are exposed to **Views** for custom reports, can be stored on a separate database, and old activity can be cleared from the **Activity Purge** tab. Because the data is stored on your own site it stays in-house, but the reports should be kept admin-facing and given a retention approach.

---

- Track page hits without a third-party analytics service.
- Self-host site statistics inside Drupal.
- Record link clicks on tagged links.
- Record impressions when items appear on a page.
- Bind stats to nodes or any entity type, not just URLs.
- Attach several counters to one entity with derivatives.
- Turn tracking on or off with a single setting.
- Exclude admin pages from tracking with URL filter rules.
- Exclude specific routes from tracking.
- Include-only mode to track just chosen pages.
- Exclude chosen user roles (e.g. administrators) from stats.
- Treat query strings as distinct elements when needed.
- View top pages and hit charts on the overview page.
- Show combo and pie charts of recent activity.
- Iterate charts backward and forward over time.
- Swap the chart library via a chart-renderer plugin.
- Build custom stats reports in Views.
- Relate entities to their stats element in Views.
- Store stats data on a separate database.
- Purge old activity-log data before a chosen date.
- Find a specific element with the element finder.
- Restrict stats administration to trusted staff.
- Give reports a data-retention approach.
- Keep stats reports admin-facing.
