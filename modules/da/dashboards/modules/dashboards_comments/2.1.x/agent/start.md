<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards comments — agent index

Submodule of [Dashboards](../../../../2.1.x/agent/start.md). Adds one **Dashboard widget**:
`comments_statistic` ("Comment per node type.", category "Statistics"), a chart of comment count per
content type. Requires `comment` + `dashboards`. No config entity, settings form, permissions, or Drush.

- The widget is a **Dashboard plugin** (see the parent's
  [plugins doc](../../../../2.1.x/agent/plugins/dashboard-plugins.md)); it is placed as block
  **`dashboards_block:dashboard:comments_statistic`** in a dashboard's Layout Builder.
- Settings: `count` = `totalcount` (all-time) or `daycount` (daily) — chooses the
  `comment_entity_statistics` column summed, grouped by node type.
- Data: SQL over `comment_entity_statistics` ⋈ `node_field_data`, cached in the `dashboards` bin.
- Also ships an optional view `dashboard_last_comments` (recent comments list).
