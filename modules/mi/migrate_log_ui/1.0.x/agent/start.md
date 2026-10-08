<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate log UI - agent index

Admin UI to browse migration messages. Depends on core `migrate`. Both routes gated by
`view migrate log messages` (restricted).

Routes:
- `/admin/migrate/log_ui/migration` -> `MigrateLogUiController::overview` (all migrations + counts).
- `/admin/migrate/log_ui/migration/{migration}/messages` -> `::logViewer` (joins message table to map table
  on `source_ids_hash`; filters via `MigrationMessageFilterForm`: level, sourceid1, message1/2 LIKE/NOT LIKE,
  group-by-message; paged 500, sortable).

Queries use parameterized conditions; output via `#type=>table`. No SQLi/XSS; access restricted. Version `1.0.x`.
