<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dashboards comments adds a Dashboards widget that charts the number of comments per content type, so you can see where discussion is happening on your site.

---

This submodule of Dashboards provides a single Dashboard plugin, `comments_statistic` ("Comment per node type."), in the "Statistics" category. Like all Dashboard widgets it is exposed as a block, `dashboards_block:dashboard:comments_statistic`, that you place into a dashboard's Layout Builder. The widget uses the shared `ChartTrait` to render a chart whose rows are `[node type, comment count]`, queried from core's `comment_entity_statistics` table joined to `node_field_data` and grouped by node type. Its settings form offers a `count` option — `totalcount` (all-time) or `daycount` (daily) — controlling which comment-count column is summed. Results are cached in the module's `dashboards` cache bin (tagged `comment_list`/`node_list`). The submodule also ships an optional view, `dashboard_last_comments`, that can be embedded to list the most recent comments. It requires the core `comment` module and `dashboards`.

---

- Chart how many comments each content type has received on an admin dashboard.
- Spot which content types drive the most discussion at a glance.
- Compare comment volume across Article, Page, and other bundles.
- Show all-time comment totals per node type (`count: totalcount`).
- Show daily comment counts per node type (`count: daycount`).
- Add the comment-statistics widget as a block via Layout Builder (`dashboards_block:dashboard:comments_statistic`).
- Place the widget alongside node statistics for a content-health overview.
- Monitor community engagement trends on a moderator dashboard.
- Identify low-engagement content types that may need attention.
- Embed the shipped `dashboard_last_comments` view to list recent comments.
- Give moderators a quick visual of comment distribution without running SQL.
- Combine with the webform or statistics widgets for a full engagement dashboard.
- Cache expensive comment aggregations automatically (invalidated on comment/node changes).
- Group the widget under the "Statistics" category in the block picker.
- Present comment metrics to non-technical editors as a chart.
- Track whether a new content type is attracting comments after launch.
- Build a per-site "discussion overview" dashboard for stakeholders.
- Reuse the widget on multiple dashboards with different count settings.
- Visualize comment data using the dashboard's configured colormap/theme.
