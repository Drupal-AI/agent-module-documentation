<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Logger (request_logger) — agent index

**HTTP middleware that logs configurable request/response metadata (status, duration, size, memory, headers, ...) to the `request_logger` logger channel.**

- **Version:** 3.0.x (3.0.0-alpha3)
- **Core:** `^11`
- **Configure:** `request_logger.settings` → `/admin/config/development/request_logger` (perm `administer site configuration`).
- **Services:** `RequestLoggerStackMiddleware` (http_middleware, priority 300); `LoggerLogEventSubscriber` (stamps request UUID onto other logs); `logger.channel.request_logger`.
- **Submodule:** `request_logger_reports` (Views report pages).
- **Captured items** (`src/StackMiddleware/RequestLoggerStackMiddleware.php`): request = uuid/method/path/query/**headers** (`getRequestDataItems()`, lines 119-152); response = code/size/duration/memory/memory_peak/page_cache/**headers** (lines 161-206). Default config captures no headers.

**Security / privacy:** only route is the admin settings form (config-gated); no anonymous or mutating endpoint. Data-at-rest concern: **no redaction** — the optional "headers" request item logs `$request->headers->all()` incl. `Authorization`/`Cookie` verbatim (middleware:141-145), response "headers" logs `Set-Cookie` (200-204), and the default-on query item may hold secrets (136-140). Where logs live and who reads them depend on enabled logger backends (e.g. dblog `watchdog` table, "access site reports"). See [configure/settings.md](configure/settings.md).
