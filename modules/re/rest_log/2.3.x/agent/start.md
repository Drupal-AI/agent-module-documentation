<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Log (rest_log) — agent index

Logs Drupal REST API requests and their responses as **`rest_log` content entities** — one row per
request: method, URI, headers, cookies, payload, response status, response headers, response body
and timing. Package *Web services*. Version **2.3.1**. Core `^8 || ^9 || ^10 || ^11`, PHP `>=7.4`.
Depends on core **`rest`**, **`views`**, **`file`**.

Capture is passive: a kernel event subscriber records every response for a route that is a REST
resource. There is no API to call — enable the module and matching traffic starts being logged.

## Solution docs

- **The `rest_log` entity, its fields, and how capture works (event subscriber + route check)** →
  [api/logging.md](api/logging.md)
- **Settings, config objects/schema, retention/cleanup, routes, permissions, the Views report** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- **Entity** `rest_log` (`src/Entity/RestLog.php`), a `ContentEntityType`, base table `rest_log`,
  owner key `user_id`. Base fields: `request_method`, `request_header`, `request_uri` (varchar
  2048), `request_cookie`, `request_payload`, `response_status`, `response_header`, `response_body`,
  `response_time` (int ms), plus `created`/`changed`. Canonical/delete routes under
  `/admin/reports/rest_log/{rest_log}`.
- **Event subscriber** `RestLogSubscriber` (`src/EventSubscriber/`) on `KernelEvents::RESPONSE`
  (prio 1000), `EXCEPTION` (-254) and `TERMINATE` (1000). Queues responses during the request and
  writes the entities on terminate.
- **Route-check service collector** — service `rest_log.route_check_manager` (`RouteCheckManager`)
  collects taggeded `rest_log.route_check` services; the one shipped checker `RestPageRouteCheck`
  (`applies()`) returns TRUE only when the route has a `_rest_resource_config` default. So only
  REST-module resource routes are logged. Add your own checker by tagging a service
  `rest_log.route_check` (implement `RestLogRouteCheckInterface`).
- **Access handler** `RestLogAccessControlHandler` — `view`/`delete` allowed by permission
  **`access rest log list`** (`rest_log.permissions.yml`).
- **Settings form** `RestLogSettingsForm` at route `rest_log.settings`
  (`/admin/config/development/logging/rest_log`, permission `administer site configuration`),
  config object `rest_log.settings` (`maximum_lifetime`, `include_same_host`).
- **Cron** `rest_log_cron()` deletes rows older than `maximum_lifetime` (in 10 000-row chunks);
  disabled when `maximum_lifetime` is 0.
- **Views report** `views.view.rest_log` at `/admin/reports/rest_log` (menu *Reports → REST API
  Logging*), plus a bulk delete action `rest_log_delete_action`.

No Drush commands, no plugin types (aside from the tagged route-check collector), no submodules.
