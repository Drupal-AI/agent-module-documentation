<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Logger — configure

Route: `/admin/config/development/request_logger` — `SettingsForm`, permission **`administer site configuration`**.

## Settings (config `request_logger.settings`)
- `log_level` — RFC5424 severity (default 6 / Info).
- `request_data` — which request items to store in log metadata. Options: `uuid`, `method`, `path`, `query`, `headers`. Default: uuid, method, path, query.
- `response_data` — response items: `code`, `size`, `duration`, `memory_usage`, `memory_usage_peak`, `page_cache`, `headers`. Default: all except `headers`.
- `message_add_data` (bool) + `message_request_data` / `message_response_data` — which items are also inlined into the human-readable message string.
- `add_request_uuid_to_logs` — when true, the event subscriber stamps `request_uuid` / `main_request_uuid` onto *all* log entries for correlation.

## Where the data goes
Entries are sent to the `request_logger` logger **channel**. The storage/rotation and read-access are whatever logger backends are enabled:
- **dblog** → `watchdog` table, viewable at `/admin/reports/dblog` with **access site reports**.
- **syslog** → OS syslog/file.

## Privacy warning
There is **no redaction**. Do not enable the `headers` request item on production unless you accept that `Authorization` and `Cookie` header values (session cookies, bearer tokens, basic-auth) are written verbatim to the log store; response `headers` includes `Set-Cookie`. The `query` item is on by default and can capture secrets passed in query strings (reset tokens, API keys). Restrict log-read permissions accordingly.

## Reports
Enable `request_logger_reports` for Views-based log/caching report tabs.
