<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards views — agent index

Submodule of [Dashboards](../../../../2.1.x/agent/start.md). **Config-only glue**: ships a ready-made
View for dashboards. No PHP plugins, no config entity of its own, no settings form, no permissions, no Drush.

- Provides the View **`dashboard_last_content`** ("Dashboard: Last content") on install — a
  `node_field_data` listing of recent content (default display access = `administer nodes`).
- Surface it on a dashboard with the base module's **Embed a view** widget
  (`dashboards_block:dashboard:view_embed`), setting its `view` to `dashboard_last_content:<display>`
  (see the parent's [plugins doc](../../../../2.1.x/agent/plugins/dashboard-plugins.md)).
- It is an ordinary View: clone/customize fields, filters, and sort as needed.
