<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Client Log (http_client_log) — agent index

Logs the **outbound HTTP requests** Drupal makes through `\Drupal::httpClient()` (core's Guzzle
client) as **content entities**, capturing the request (method, URL, headers, body) and the response
(status, reason, headers, body). Version **1.2.1**, package `Development`, core `^8.8 || ^9 || ^10 || ^11`.
Depends on `drupal:options` and the Composer library `covergenius/guzzle_logger` (`^2.3`).

## Mechanism (verified from source)

- **Service decoration** — `http_client_log.services.yml` defines `http_client_log_decorator`
  (`src/HttpClientLogService.php`, `class HttpClientLogService extends ClientFactory`) which
  `decorates: http_client_factory` at `decoration_priority: 1`. Its constructor pushes
  `GuzzleLogMiddleware\LogMiddleware` (from `covergenius/guzzle_logger`) onto the core
  `@http_handler_stack`, wired to a custom `SimpleHandler` and a custom `Logger`. Every client
  produced by `\Drupal::httpClient()` is therefore instrumented — there is no per-request opt-in.
- **The logger** — `src/Logger/Logger.php` implements `LoggerInterface`. `SimpleHandler` (in
  `HttpClientLogService.php`) fires after each transfer and calls `Logger::log()` with
  `context['request']`, `context['response']`, `context['options']`, `context['exception']`.
- **Filter chain** (in `Logger::log()`, applied in order; any failure returns without logging):
  1. `log_enabled` global toggle.
  2. Time filter — `time_filter_start`/`time_filter_end` (H:i, supports overnight windows) and
     `time_filter_days` (0=Sun…6=Sat), evaluated in the site timezone.
  3. URL filter — `url_filter_mode` `none|allow|deny` over `url_filter_patterns` matched with
     `fnmatch(..., FNM_CASEFOLD)` against the full request URI.
  4. Request-method filter — `request_method_filter` (empty = all methods).
  5. `only_log_when_response` — skip when no response object exists.
  6. Response-status filter — `response_status_filter` `all|errors` (>=400) `|successful` (2xx).
  7. Response Content-Type filter — `response_content_type_filter`, case-insensitive **substring**
     match on the response `Content-Type` header; defaults to `text/html`, `json`, `application/xml`.
- **What is stored** — a `http_client_log` content entity (`src/Entity/HttpClientLogEntity.php`,
  `base_table: http_client_log`) with base fields: `request_http_method`, `request_url`,
  `request_headers` (all headers joined `Name: v1|v2`), `request_payload` (request body contents),
  `response_status_code`, `response_reason_phrase`, `response_headers`, `response_body`
  (response body contents), `errors` (exception message), plus `name`, `user_id` (current user at
  creation), `status`, `created`, `changed`. **Headers and bodies are stored verbatim; the module
  performs no redaction or truncation.**
- **Retention** — `hook_cron()` in `http_client_log.module` prunes the `http_client_log` table to
  `log_retention_limit` rows (default `100000`; `0` = keep all).

## Surfaces & access

- **Settings form** — `/admin/config/services/http-client-logs`
  (`src/Form/SettingsForm.php`, route requires `administer site configuration`). Exposes every filter
  above plus the retention limit. See `agent/config/settings.md`.
- **Listing** — a View, `views.view.http_client_log`, at `/admin/reports/http-client-logs`, whose
  access is `perm: administer http client log entity entities`.
- **Detail page** — `/admin/reports/http-client-logs/{http_client_log}`, route
  `entity.http_client_log.canonical`, requirement `_entity_access: http_client_log.view`
  (`src/HttpClientLogEntityAccessControlHandler.php`).
- **Permissions** — `http_client_log.permissions.yml` defines `add`, `edit`, `delete`,
  `view published`, `view unpublished`, and `administer` `http client log entity entities`, plus
  dynamic per-bundle permissions from `HttpClientLogEntityPermissions`. Logs are created **published**,
  so `view published http client log entity entities` grants read access to the detail pages.

## Config & schema

- `config/install/http_client_log.settings.yml` — installed defaults (`log_enabled: true`,
  filters empty/`none`/`all`, `only_log_when_response: true`, retention `100000`, content-type
  `text/html,json,application/xml`).
- `config/schema/http_client_log.schema.yml` — schema for all settings keys.
- `config/install/views.view.http_client_log.yml` — the listing View.
- A `http_client_log_entity_type` config bundle entity (`src/Entity/HttpClientLogEntityType.php`)
  provides the single `http_client_log` bundle and its structure forms.

## How to exercise it

```php
// Any outbound call through the core client is logged (subject to the filters):
$response = \Drupal::httpClient()->get('https://httpbin.org/get');
// Then browse /admin/reports/http-client-logs and open the entry.
```

## Files

- `agent/config/settings.md` — every setting on the configuration form and its config key.
- `agent/api/mechanism.md` — the decoration/middleware wiring and how to read logs programmatically.

## Cautions for real use

Package `Development` is deliberate: this is a full capture of what the site sends and receives.
Outbound API calls routinely carry Authorization headers, bearer tokens, API keys and request/
response bodies, and all of it lands in the `http_client_log` table (and thus in DB backups)
verbatim. Enable it for a targeted investigation, keep the view/administer permissions on trusted
roles only, use the URL/method/status/Content-Type filters to capture as little as possible, and
keep a retention limit set so the table cannot grow without bound.
