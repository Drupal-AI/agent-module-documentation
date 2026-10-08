<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Statistics — agent index

Logs how many times each node is viewed. Keeps a per-node total count, daily count, and
last-viewed timestamp in the `node_counter` table. Depends on `node`. Counting is off by
default — enable it with the `count_content_views` setting. Formerly Drupal core.

- **Turn view counting on/off, settings keys, the "Popular content" block** → [configure/settings.md](configure/settings.md)
- **Read / record counts in code (the storage service & API)** → [api/counts.md](api/counts.md)
- **Permissions (administer statistics, view post access counter)** → [permissions/permissions.md](permissions/permissions.md)

Quick facts:
- Configure route: `statistics.settings` → `/admin/config/system/statistics` (needs `administer statistics`).
- Config object: `statistics.settings` (`count_content_views`, `display_max_age`).
- Storage service: `statistics.storage.node` (implements `Drupal\statistics\StatisticsStorageInterface`).
- Table: `node_counter` (`nid`, `totalcount`, `daycount`, `timestamp`).
- Also ships: `statistics_popular_block` block, Views field plugins, tokens (`[node:total-count]`, `[node:day-count]`, `[node:last-view]`). No Drush commands.
