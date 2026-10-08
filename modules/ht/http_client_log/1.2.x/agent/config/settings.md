<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — http_client_log.settings

Form: `src/Form/SettingsForm.php` at `/admin/config/services/http-client-logs`
(route `http_client_log.settings`, requires `administer site configuration`).
Config object: `http_client_log.settings` (schema in `config/schema/http_client_log.schema.yml`).
Filters are evaluated top-to-bottom in `Logger::log()`; a request is recorded only if it passes all.

| Config key | Type | Install default | Effect |
|---|---|---|---|
| `log_enabled` | boolean | `true` | Master switch. `false` disables all logging. |
| `url_filter_mode` | string | `none` | `none` = log all; `allow` = only log URLs matching a pattern; `deny` = skip URLs matching a pattern. |
| `url_filter_patterns` | sequence(string) | `[]` | One `fnmatch` pattern per line; `*` = any substring, `?` = any single char; matched case-insensitively against the full request URL. Only used when mode ≠ `none`. |
| `time_filter_start` | string `H:i` | `''` | Start of the daily window. Time filtering is active only when both start and end are non-empty. |
| `time_filter_end` | string `H:i` | `''` | End of the window. If end < start it is treated as an overnight window (e.g. `22:00`–`06:00`). |
| `time_filter_days` | sequence(int) | `[]` | Days of week to log (0=Sun … 6=Sat). Empty = every day. Only consulted when the start/end window is set. |
| `request_method_filter` | sequence(string) | `[]` | Methods to log (GET/POST/PUT/DELETE/HEAD/PATCH). Empty = all methods. |
| `only_log_when_response` | boolean | `true` | When `true`, requests that produced no response object (e.g. connection failure) are skipped. |
| `response_status_filter` | string | `all` | `all` = every response; `errors` = only status ≥ 400; `successful` = only 2xx. 1xx/3xx are dropped in the non-`all` modes. |
| `response_content_type_filter` | sequence(string) | `text/html`, `json`, `application/xml` | Record only when the response `Content-Type` header contains (case-insensitive substring) one of these. Applies only when a response exists. Clear it to record regardless of content type. |
| `log_retention_limit` | integer | `100000` | Max rows kept in the `http_client_log` table; `hook_cron` prunes to this. Select `All` (`0`) to never prune. Options: 0, 1000, 10000, 100000, 200000, 300000, 500000, 1000000. |

Notes:

- The time filter runs in the site default timezone (`date_default_timezone_get()`).
- The Content-Type match is a substring test, so `json` matches `application/json`,
  `application/problem+json`, etc.
- Filters reduce **what is captured**; they do not redact fields within a captured entry — a logged
  request/response is stored with its headers and body intact.
