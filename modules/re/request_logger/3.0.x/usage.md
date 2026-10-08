<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Request Logger writes one log entry per HTTP request/response to the Drupal logger, recording configurable request and response data (status code, duration, size, memory usage, and more).

---

For debugging and performance monitoring it is useful to have a record of each request that hit the site and how it performed. Request Logger installs an HTTP middleware (`RequestLoggerStackMiddleware`, priority 300) that wraps the kernel: it assigns each request a UUID, lets the request run, then logs a message plus a `metadata` context to the `request_logger` logger channel. A `LoggerLogEventSubscriber` can also stamp the request/main-request UUID onto other log entries so all logs from one request can be correlated. Which items are captured is controlled at `/admin/config/development/request_logger` (permission `administer site configuration`). Available request items are: uuid, method, path, query string, and **all request headers**; response items are: status code, size, duration, memory usage, peak memory, page-cache HIT/MISS, and **all response headers**. Defaults capture uuid/method/path/query (request) and code/size/duration/memory/memory-peak/page-cache (response).

The optional `request_logger_reports` submodule adds Views-based report pages. Because entries go through Drupal's logger channel, where they end up (database log / syslog / file) and who can read them is determined by whichever core/contrib logger backends are enabled — e.g. dblog stores them in the `watchdog` table, readable with the "access site reports" permission. Security/privacy note: this module can log data at rest but applies **no redaction**. The default settings do not capture headers or POST bodies, but the "Headers" request item (if an admin enables it) records `$request->headers->all()` verbatim — including `Authorization` and `Cookie` — and the response "Headers" item records `Set-Cookie`; the query-string item is on by default and may contain tokens/secrets. Nothing is anonymous or mutating: the only route is the admin settings form.

---

- Log every HTTP request with method and path.
- Record response status codes for all requests.
- Measure per-request duration.
- Track memory usage and peak memory per request.
- Record response size in KB.
- Capture page-cache HIT/MISS per request.
- Assign a UUID to each request for correlation.
- Correlate subsequent log entries to a request UUID.
- Choose the log severity level for entries.
- Enable/disable individual request data items.
- Enable/disable individual response data items.
- View request logs via the request_logger_reports submodule.
- Debug slow endpoints by inspecting duration.
- Detect memory-heavy requests.
- Audit which paths are being requested.
- Add request headers to log entries for debugging (privacy-sensitive).
- Add response headers to log entries.
- Send logs to syslog/dblog depending on enabled logger backends.
- Restrict configuration to administrators via 'administer site configuration'.
- Correlate sub-requests to their main request UUID.
