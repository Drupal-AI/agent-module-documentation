# DB Maintenance — agent index

Cron-driven utility that runs `OPTIMIZE TABLE` (MySQL/MariaDB) or `VACUUM` (PostgreSQL) on
selected tables. All settings live in the **`db_maintenance.settings`** config object; the
last-run timestamp is in state (`db_maintenance.cron_last_run`). No entities, fields, or
plugin types.

- **Settings keys, the admin form, scheduling, time window, table selection, drush config** →
  [configure/settings.md](configure/settings.md)
- **What runs at cron time, the OPTIMIZE/VACUUM drivers, the manual "Optimize now" run** →
  [api/mechanism.md](api/mechanism.md)
- **The one permission it defines** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route: `db_maintenance.admin_settings` at `/admin/config/system/db_maintenance`.
- Config object `db_maintenance.settings` keys: `cron_frequency` (int seconds; `0` = every cron),
  `use_time_interval` (bool), `time_interval_start` / `time_interval_end` (`'HH:MM'`),
  `all_tables` (bool), `write_log` (bool), `table_list` (sequence keyed by **database name**).
- Manual run: `/db_maintenance` (route `db_maintenance.optimize_tables_page`, CSRF-token protected).
- Permission: `administer db maintenance`.
