<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# rest_log — the log entity and how capture works

## The `rest_log` entity

`src/Entity/RestLog.php` — a `@ContentEntityType` (`id = "rest_log"`, base table `rest_log`,
owner entity key `user_id`; implements `EntityChangedInterface`, `EntityOwnerInterface`). Its
`label()` is `"{request_method} {request_uri}"`. Handlers: core `EntityViewBuilder`,
`EntityViewsData`, the module's `RestLogAccessControlHandler`, core delete / delete-multiple
forms, and `DefaultHtmlRouteProvider`. Links: canonical `/admin/reports/rest_log/{rest_log}`,
delete `…/{rest_log}/delete`, delete-multiple `/admin/reports/rest_log/delete`.

Base fields (`baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `request_method` | string | e.g. GET/POST |
| `request_header` | string_long | `print_r()` of processed request headers |
| `request_uri` | string | max_length 2048 (update 9007 widened the column) |
| `request_cookie` | string_long | `print_r()` of processed cookies |
| `request_payload` | string_long | raw request body |
| `response_status` | string | HTTP status code |
| `response_header` | string_long | `print_r()` of processed response headers |
| `response_body` | string_long | JSON-encoded decoded response |
| `response_time` | integer | milliseconds |
| `user_id` (owner) | entity_reference → user | display-configurable |
| `created` / `changed` | created/changed | timestamps |

Field history (`rest_log.install`): update 9003 added `response_time`, 9005 added
`response_header`, 9006 removed the old `error_code`/`error_message` fields, 9007 grew
`request_uri` to varchar 2048 (skipped on SQLite).

## Capture path — `RestLogSubscriber`

Service `rest_log_subscriber` (`src/EventSubscriber/RestLogSubscriber.php`), args:
`@config.factory`, `@datetime.time`, `@logger.factory`, `@entity_type.manager`,
`@rest_log.route_check_manager`. Subscribed events (`getSubscribedEvents()`):

- `KernelEvents::RESPONSE` → `logResponse()` (prio 1000)
- `KernelEvents::EXCEPTION` → `onException()` (prio -254)
- `KernelEvents::TERMINATE` → `terminate()` (prio 1000)

Flow:
1. `logResponse()` first calls `routeCheckManager->check()`; if no checker applies it returns
   without logging. It then reads the `referer` header — when the request host equals the
   referer host **and** `include_same_host` is off, it skips. Otherwise it pushes
   `['request' => …, 'response' => …]` onto an `\SplStack`.
2. `onException()` (for REST routes) stores the throwable and replaces the response with a
   generic `ResourceResponse(['status' => 'error', 'message' => 'System error, please contact
   the site administrator.'])`.
3. `terminate()` drains the stack, calling `doLogResponse()` per item, catching `\Error` and
   logging it to the `rest_log` logger channel.
4. `doLogResponse()` decodes the response body by content type — `application/octet-stream` →
   `'File'` (files are not stored), `text/xml` → `XmlEncoder::decode`, else `Json::decode`. If an
   exception occurred, adds `$responseBody['Exception']`. For `application/octet-stream` requests
   the request body is dropped. Response time is `round(1000 * (microtime(TRUE) -
   time->getRequestMicroTime()))`. It builds the field values with `array_filter([...])` and does
   `entityTypeManager->getStorage('rest_log')->create($values)->save()`, logging an
   `EntityStorageException` to the `rest_log` channel on failure.

Headers and cookies are pre-processed by `cleanUpHeaders()` / `cleanUpCookies()` (collapse
single-element header arrays; mask session cookies by prefix and header values by name) before
being stored via `print_r()`.

## Which routes are logged — the route-check collector

- `rest_log.route_check_manager` → `RouteCheckManager` (implements `RouteCheckManagerInterface`),
  tagged `service_collector` for tag `rest_log.route_check` (calls `addChecker`). `check()`
  returns TRUE if any collected checker's `applies()` returns TRUE.
- Shipped checker `rest_log.rest_page` → `RestPageRouteCheck` (`src/RestLogRouteCheck/`), arg
  `@current_route_match`. `applies()` returns TRUE only when the current route
  `hasDefault('_rest_resource_config')` — i.e. a REST-module resource route.
- To log additional routes, register a service implementing `RestLogRouteCheckInterface` and tag
  it `rest_log.route_check`; its `applies()` is OR-ed with the others.

Consequence: only REST-resource routes are captured, and a response already served from the page
cache never reaches the subscriber, so it produces no log entry.
