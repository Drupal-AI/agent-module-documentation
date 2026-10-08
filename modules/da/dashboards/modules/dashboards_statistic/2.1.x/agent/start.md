<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards statistics — agent index

Submodule of [Dashboards](../../../../2.1.x/agent/start.md). Adds one **Dashboard widget**:
`node_most_readed` ("Show most visited.", category "Statistics"), a chart of page views per content
type from core Statistics. Requires `statistics` + `dashboards`. No config entity, settings form,
permissions, or Drush.

- Placed as block **`dashboards_block:dashboard:node_most_readed`** in a dashboard's Layout Builder
  (see the parent's [plugins doc](../../../../2.1.x/agent/plugins/dashboard-plugins.md)).
- Settings: `count` = `totalcount` (all-time views) or `daycount` (today) — selects the `node_counter`
  column summed, grouped by node type.
- Data: SQL over `node_counter` ⋈ `node_field_data`, cached in the `dashboards` bin.
