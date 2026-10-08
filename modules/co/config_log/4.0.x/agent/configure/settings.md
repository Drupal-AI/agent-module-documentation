# Configure Configuration Log

Config object: **`config_log.settings`**. UI: `config_log.admin` →
`/admin/config/development/config_log` (permission `administer site configuration`), also under
*Configuration → Development → Configuration Log*. Read/write with `drush cget`/`cset` or the
config API — there is no Drush command of its own.

## Settings keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `log_destination` | map | `{ custom: 'custom' }` | Active destinations. Keys: `custom` (DB table `config_log`), `default` (watchdog/dblog PSR logger), `mail`. A destination logs only when its key is present and truthy. |
| `log_email_address` | string | – | Recipient for the `mail` destination. |
| `mail_subject` | label | `[@site] Configuration change` | Email subject. Placeholders: `@site`, `@id`, `@config_name`, `@time`. |
| `mail_body` | text | `User ID: @id<br />@changes` | Email body. Placeholders above plus `@changes` (the generated diff). |
| `logs_to_keep` | int | `0` | Row cap for the `custom` table (`0` = keep all; UI offers 100/1k/10k/100k/1M). Enforced by cron. Forced to `0` on save unless the `custom` destination is enabled. |
| `ignore_config_import` | bool | `false` | If true, changes made during a config import are not logged. |
| `ignore_no_changes` | bool | `false` | If true, a save that changed nothing is skipped (compares encoded original vs new). |
| `log_ignored_config` | sequence | `[]` | Config names/patterns to ignore, `*` = wildcard, must match the full name (e.g. `user.*`, `*.settings`). |
| `log_ignored_config_negate` | bool | `false` | Invert the list: log **only** names that match it (a whitelist). |
| `redact_sensitive_config_values` | bool | `true` | Redact likely-secret leaf values to `[redacted]` before storing/logging. |
| `leading_context_lines` | number | `0` | Unchanged lines shown before each diff hunk (0–50; used by the Views diff field). |
| `trailing_context_lines` | number | `0` | Unchanged lines shown after each diff hunk (0–50). |

The config **schema** is `config_log.settings` (`config/schema/config_log.schema.yml`).

## Ignore-list semantics

`isIgnored($name)` builds a regex per pattern (`preg_quote` then `*` → `.*`, anchored full-match).
- Negate **off** (default): a match → **ignore** (don't log); no match → log.
- Negate **on**: a match → **log**; no match → ignore. Use this to log only a whitelist.

## Drush examples

```bash
# Enable the DB table + watchdog, disable mail:
drush cset config_log.settings log_destination.custom custom -y
drush cset config_log.settings log_destination.default default -y

# Log only user.* config (whitelist):
drush cset config_log.settings log_ignored_config.0 'user.*' -y
drush cset config_log.settings log_ignored_config_negate true -y

# Keep only the last 1000 rows in the custom table:
drush cset config_log.settings logs_to_keep 1000 -y

# Turn off secret redaction (not recommended):
drush cset config_log.settings redact_sensitive_config_values false -y
```

Read a value back: `drush cget config_log.settings redact_sensitive_config_values`.
