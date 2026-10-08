# JSON Log — agent index

A PSR-3 logger service (`logger.jsonlog`, tagged `logger`) that writes every Drupal log event, at/above a
severity threshold, as one JSON object per line — to a file or STDOUT. No permissions, no Drush; settings
live on core's Logging form.

- **All settings, env-var overrides, output modes, the JSON entry shape** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Service `logger.jsonlog` = `Drupal\jsonlog\Logger\JsonLog` (tag `{ name: logger }`); entry value object
  `JsonLogData`.
- Config object `jsonlog.settings`; `configure` route = `system.logging_settings` (core "Logging and
  errors"), fields injected via `hook_form_FORM_ID_alter` in `jsonlog.inc`.
- Every setting can be overridden by a `drupal_<setting>` **environment variable** (wins over config,
  disables the form field). Tags from env + config are combined.
- Output: STDOUT (`php://stdout`) or file `{dir}/{site_id}[.{date}].json.log`, appended with
  `FILE_APPEND | LOCK_EX`.
- Defaults: threshold 4 (warning), truncate 64 Kb, `Ymd` daily rotation, site_id = hostname+db name,
  dir = PHP `error_log` dir + `/drupal-jsonlog`.
