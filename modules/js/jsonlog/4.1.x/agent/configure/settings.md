# Configure JSON Log

Settings live on **core's** Logging form (`/admin/config/development/logging`, route
`system.logging_settings`) under a "JSON Log" fieldset injected by `hook_form_FORM_ID_alter`
(`jsonlog.module` → `_jsonlog_form_system_logging_settings_alter()` in `jsonlog.inc`). They persist to the
`jsonlog.settings` config object. Access is core's `administer site configuration`. No module-specific
permission or Drush command.

## Settings (config `jsonlog.settings`)

| Key | Default (`config/install`) | Meaning |
|---|---|---|
| `jsonlog_severity_threshold` | `4` (warning) | Log only events at/above this RFC severity (lower number = more severe; `0`/emergency is disallowed). |
| `jsonlog_channels` | `''` | Comma-separated channel whitelist; empty = all channels. |
| `jsonlog_truncate` | `64` | Max message size in **Kb** (0 = no truncation). Sized to stay within a filesystem block to avoid garbled concurrent writes. |
| `jsonlog_siteid` | `''` → derived | Site identifier; default = `strtolower(hostname) . '__' . db_name [. '__' . prefix]`. |
| `jsonlog_canonical` | `''` | Stable name across load-balanced instances of the same site. |
| `jsonlog_stdout` | `false` | If true, write to `php://stdout` instead of a file (containers). |
| `jsonlog_file_time` | `'Ymd'` | File rotation: `none` (one file forever) / `Ymd` (day) / `YW` (week) / `Ym` (month). |
| `jsonlog_dir` | `''` → derived | Log directory; default = dir of PHP `error_log` (or `/var/log/apache2`|`httpd`) + `/drupal-jsonlog`. |
| `jsonlog_newline_prepend` | `false` | Legacy: prepend rather than append the entry newline. |
| `jsonlog_tags` | `''` | Comma-separated tags added to every entry. |

Final file path: `{jsonlog_dir}/{site_id}[.{date}].json.log`. The web server user must be able to write
there (README suggests creating a `drupal-jsonlog` subdir and chowning it).

## Environment-variable overrides (distinctive feature)

For **every** setting, a `drupal_<setting>` environment variable takes precedence over config and, in the
form, disables (greys out) that field showing "overridden". Examples: `drupal_jsonlog_dir`,
`drupal_jsonlog_stdout`, `drupal_jsonlog_severity_threshold`, `drupal_jsonlog_siteid`,
`drupal_jsonlog_channels`, `drupal_jsonlog_truncate`, `drupal_jsonlog_file_time`,
`drupal_jsonlog_canonical`, `drupal_jsonlog_newline_prepend`, `drupal_jsonlog_tags`. Resolution lives in
`JsonLog::loadDefaultSettings()`. **Tags are combined** (server env tags + site config tags), not
replaced. Note: env vars set in vhost/.htaccess are not visible to drush/CLI (use `/etc/environment`).

## Output & entry shape

`JsonLog::log()` skips events below the threshold or outside the channel whitelist, builds a
`JsonLogData`, and writes `Json::encode(...)`:
- STDOUT mode: `file_put_contents('php://stdout', json)`.
- File mode: `file_put_contents($file, $prepend . json . $append, FILE_APPEND | LOCK_EX)` (write-locked).
- On write failure it falls back to PHP `error_log()`.

Each JSON entry (`JsonLogData::getData()`) includes: `@timestamp` (ms ISO-8601), `@version`, `message`,
`message_id` (`uniqid(site_id)`), `site_id`, `canonical`, `tags`, `type` (`drupal`), `subtype` (channel,
≤64 chars), `severity`, `method`, `request_uri`, `referer`, `uid`, `client_ip` (≤128 chars),
`link`/`code`, `trunc` (`[orig_len, new_len]` when truncated). `setMessage()` resolves placeholders,
`strip_tags()` when the message starts with `<`, escapes null bytes (`_NUL_`), and truncates multibyte-safe.

## Verify

Tick **Log test entry** on the settings form to write a sample entry (message shows the target file path)
after saving — the quickest way to confirm directory/permissions.
