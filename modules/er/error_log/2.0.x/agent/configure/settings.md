# Configure Error Log

No dedicated route. The module alters core's **Logging and errors** form
(`/admin/config/development/logging`, route `system.logging_settings`, permission
`administer site configuration`) to add an "Error Log" section. All state lives in the
`error_log.settings` config object.

## Config keys (`error_log.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `log_levels` | mapping `level_0`…`level_7` → bool | all `true` | Which severities are sent. `level_0`=Emergency … `level_7`=Debug (RFC 5424 order). |
| `ignored_channels` | sequence of strings | `[]` | Log channels to drop. Edited as one-per-line in a textarea. Common values: `page not found` (404s), `access denied` (403s). |
| `format` | string (maxlength 280) | `[!level] [!type] [!ip] [uid:!uid] [!request_uri] [!referer] !message` | Line template; `!`-placeholders below. |

### Drush / config edits

```bash
# Stop logging debug + info (level_6/7) to the error log:
drush config:set error_log.settings log_levels.level_7 false -y
drush config:set error_log.settings log_levels.level_6 false -y
# Ignore 404 and 403 noise:
drush config:set error_log.settings ignored_channels '["page not found","access denied"]' -y
# Custom one-line format:
drush config:set error_log.settings format '[!severity] !type: !message (uid:!uid ip:!ip)' -y
```

## Format placeholders

Substituted per event by `Drupal\error_log\Logger\ErrorLog::log()`:

- `!level` — severity as PSR string (`emergency`…`debug`).
- `!severity` — severity as integer 0–7 (RFC 5424).
- `!type` — the log channel (e.g. `php`, `cron`, `system`).
- `!message` — the message with its placeholders already substituted.
- `!ip` — client IP of the triggering request.
- `!uid` — user id.
- `!request_uri` — requested URI.
- `!referer` — HTTP referer, if any.
- `!base_url` — site base URL.
- `!link` — the operation link associated with the message, if any.
- `!timestamp` — Unix timestamp of the event.

## Filtering behavior (why a message might not appear)

1. Severity off in `log_levels` → skipped.
2. Event `channel` present in `ignored_channels` → skipped.
3. Running under Drush **and** the PHP `error_log` ini directive is empty → skipped (Drush already logs to the console). Set the `error_log` ini directive to force CLI logging.

The destination of the write is PHP's own `error_log()` — i.e. wherever the `error_log`
ini directive points (Apache/nginx error log, stderr, syslog). It is not configurable in Drupal.
