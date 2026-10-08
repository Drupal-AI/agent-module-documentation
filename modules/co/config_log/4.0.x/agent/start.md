# Configuration Log — agent index

Logs every core config change (SAVE / DELETE / RENAME / IMPORT) to up to three
destinations. One global settings object, three event subscribers, one DB table, no plugins,
no permissions of its own, no Drush.

- **All settings keys, the config UI, destinations, ignore list, retention** →
  [configure/settings.md](configure/settings.md)
- **How logging works (event subscribers, the `config_log` table, secret redaction, cron pruning)** →
  [api/mechanism.md](api/mechanism.md)
- **Add your own log destination (custom EventSubscriber)** → [extend/custom-destination.md](extend/custom-destination.md)
- **Config Log Views submodule** (report at `/admin/reports/config-log`, Views data, diff field) →
  `../../modules/config_log_views/4.0.x/agent/start.md`

Key facts:
- Settings live in `config_log.settings`; config route `config_log.admin` at
  `/admin/config/development/config_log` (permission `administer site configuration`).
- Destinations are keyed `custom` (DB table `config_log`), `default` (watchdog/PSR logger),
  `mail`. Stored under `log_destination` as a map; a destination is active only when its key is
  present **and truthy**. Default install ships `{ custom: 'custom' }` (DB only). A literally
  empty map (never-saved) is treated as "all active"; once the form is saved it is never empty.
- The DB table `config_log` stores `data` and `originaldata` as YAML for diffing.
- Sensitive leaf values are redacted to `[redacted]` by default (`redact_sensitive_config_values`).
