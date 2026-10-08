<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Smartsheet (migrate_smartsheet) — agent index

**Migrate process plugin `smartsheet`: extract a cell value from a Smartsheet row's cell array by `column_id`.**

- **Version:** 1.3.x (dev checkout, branch 1.3.x)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends:** migrate, migrate_plus, migrate_tools
- **Plugin id:** `smartsheet`. Config: `column_id`, `return_key`, optional `compare_value` + `return_true_value`/`return_false_value`.
- **Security:** developer/CLI migration tool; no routes, permissions, or UI; Smartsheet API auth/token is handled by the (separate) source plugin, not here.

See [api/plugin.md](api/plugin.md).
