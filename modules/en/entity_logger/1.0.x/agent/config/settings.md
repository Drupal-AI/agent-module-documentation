<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config schema, cron cleanup & permissions (entity_logger)

Source: `src/Form/EntityLoggerSettingsForm.php`, `config/install/entity_logger.settings.yml`,
`config/schema/entity_logger.schema.yml`, `src/EntityLoggerSchemaHelper.php`,
`src/Hook/CronHooks.php`, `entity_logger.routing.yml`, `entity_logger.permissions.yml`,
`entity_logger.links.*.yml`, `entity_logger.install`.

## Install / enable

`composer require drupal/entity_logger` then enable `entity_logger` (pulls in
`dynamic_entity_reference` and `views`). Core `^10.2 || ^11`. After enabling, open the settings form
and choose which entity types to log — nothing is logged until at least one type is enabled.

## Settings form

Route `entity_logger.settings` → `/admin/config/system/entity_logger`, form
`EntityLoggerSettingsForm` (`ConfigFormBase`, `getFormId()` = `entity_logger_settings_form`),
requirement `_permission: administer entity logger`, `_admin_route: TRUE`. Menu link under
*Configuration → System* (`entity_logger.links.menu.yml`). Edits config object
`entity_logger.settings`.

Fields (each wired with a `ConfigTarget`):

- **Enabled entity types** (`enabled_entity_types`) — checkboxes from
  `EntityLoggerInterface::getAvailableEntityTypesForLogging()`; unchecked values are filtered out and
  stored as a re-indexed sequence.
- **Retention period** (`retention_period`) — select of days: Never delete (0), 7, 30, 90, 180, 365.
  Cast to int on save.
- **Batch size** (`batch_size`) — number 1–1000; entries deleted per batch during bulk cleanup.

## Config object & schema

`entity_logger.settings` (`config/install/entity_logger.settings.yml`): `enabled_entity_types: {}`,
`retention_period: 90`, `batch_size: 100`. Schema (`config/schema/entity_logger.schema.yml`,
`FullyValidatable`):

- `enabled_entity_types` — sequence of strings, each constrained `NotBlank` + `Choice` whose callback
  `EntityLoggerSchemaHelper::getAvailableEntityTypeIdsForLogging` lists valid entity type ids.
- `retention_period` — integer, `Range min: 0`.
- `batch_size` — integer, `Range min: 1 max: 1000`.

Update hooks (`entity_logger.install`): `entity_logger_update_10001` adds `retention_period` (default
0), `entity_logger_update_10002` adds `batch_size` (default 100), for sites installed before those
settings existed.

## Cron retention cleanup

`CronHooks::cron()` (service arg `$logger = @logger.channel.entity_logger`): if `retention_period > 0`,
computes a cutoff of `request_time - days*86400` and deletes `entity_log_entry` rows older than the
cutoff in batches of `batch_size` (default 100), sorting by `id`, resetting the entity cache between
batches to bound memory. A soft time limit of 10s per cron run stops the loop early (logging a
`warning`); a summary `notice` is logged when anything was deleted. `retention_period = 0` disables
cleanup (keep forever).

## Permissions (`entity_logger.permissions.yml`)

- `view entity log entries` — view entries (also gates the per-entity Log route/view and the "Log"
  operation link).
- `add entity log entries` — create via the add form.
- `edit entity log entries` — edit.
- `delete entity log entries` — delete.
- `administer entity log entries` — entity `admin_permission`; gates the admin collection
  `/admin/structure/entity_logger`.
- `administer entity logger` — `restrict access: true`; gates the settings form.

## Routes & links summary

- `entity_logger.settings` — settings form (`administer entity logger`).
- `entity.entity_log_entry.collection` `/admin/structure/entity_logger` — admin list (from the entity's
  `AdminHtmlRouteProvider`, `administer entity log entries`); menu link + a "List" local task.
- `entity.<type>.entity_logger` — per-entity Log tab, added dynamically by `RouteSubscriber`
  (`view entity log entries`).
- Add/edit/delete forms under `/entity_logger/…` (see entity/log-entry.md).
