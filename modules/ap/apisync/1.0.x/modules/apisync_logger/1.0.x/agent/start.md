<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Sync Logger (apisync_logger) — agent index

Submodule of [apisync](../../../../1.0.x/agent/start.md). Consolidated logging via an event subscriber. Package `Liip`, core `^9 || ^10 || ^11`. Depends on `apisync`. `configure: apisync_logger.settings`.

## What it provides
- **Event subscriber** `Drupal\apisync_logger\EventSubscriber\ApiSyncLoggerSubscriber` (service `apisync_logger.event_subscriber`, args `@logger.channel.apisync`, `@config.factory`). Subscribes to `ApiSyncEvents::ERROR|WARNING|NOTICE` → `apiSyncException()`.
  - Filters by `apisync_logger.settings:log_level`: skips events below the configured minimum.
  - If the event carries an exception, logs `Error::decodeException($exception)` with the placeholder `%type: @message in %function (line %line of %file).`; otherwise logs `$event->getMessage()` + `$event->getContext()`.
- **Logger channel** service `logger.channel.apisync` (parent `logger.channel_base`, channel `apisync`).
- **Settings form** `Drupal\apisync_logger\Form\SettingsForm` at `/admin/config/apisync/logger` (route `apisync_logger.settings`, `_permission: administer apisync`). Radios: `apisync.error` (default), `apisync.warning`, `apisync.notice`.

## Config
`apisync_logger.settings` (schema `config/schema/apisync_logger.schema.yml`): `log_level` (string; default `"apisync.error"`).

## Notes
Log level constants come from `Drupal\apisync\Event\ApiSyncEvents`. The subscriber logs exception metadata and event context/messages — it does not log auth headers or credentials.
