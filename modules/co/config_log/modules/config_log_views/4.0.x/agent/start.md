# Config Log Views — agent index

Views integration for the parent **config_log** module. Registers the `config_log` DB table as a
Views base table, adds a custom diff field, and ships a report view. No config UI of its own
(its configure link points at `config_log.admin`), no permissions, no plugin types, no Drush.

- **The report view, the `config_log_diff` field, and the Views data it exposes** →
  [configure/views-integration.md](configure/views-integration.md)
- Parent module (settings, subscribers, table, redaction) → `../../../4.0.x/agent/start.md`

Key facts:
- Default view `views.view.config_log`; Page display path **`admin/reports/config-log`**
  (menu "Config Log" under Reports). `base_table: config_log`.
- Diff field plugin id **`config_log_diff`** (class `ConfigLogDiff`) diffs `originaldata` vs
  `data` using core `DiffFormatter`, reading `leading_context_lines` / `trailing_context_lines`
  from `config_log.settings`.
- `hook_views_pre_render()` attaches the `system/diff` library so diffs render with core styling.
- Uninstalling the submodule deletes `views.view.config_log`.
