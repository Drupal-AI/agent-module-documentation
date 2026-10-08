<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Logger (entity_logger) — agent index

Records **log messages against specific entities** (per-entity activity log, e.g. "synced to CRM",
"import failed"). Defines an internal `entity_log_entry` content entity whose `target_entity` is a
**dynamic_entity_reference**, so an entry can point at any entity type. Depends on
`dynamic_entity_reference` and `views`. Config object `entity_logger.settings` (route
`entity_logger.settings`). Provides permissions and config schema; no Drush, no new plugin types.
Version-dir **1.0.x** (installed 1.0.13). Core `^10.2 || ^11`. License GPL-2.0-or-later.

## Solution docs

- **Logging API — the `entity_logger` service, per-entity instance/factory, `log()`, channels, the
  AvailableEntityTypes event** → [api/logging.md](api/logging.md)
- **The `entity_log_entry` content entity — fields, storage, access handler, view builder, list
  builder, Views integration, routes/local tasks** → [entity/log-entry.md](entity/log-entry.md)
- **Settings form, config schema, enabled entity types, cron retention cleanup, permissions** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- Content entity `entity_log_entry` (`src/Entity/EntityLogEntry.php`, `base_table = entity_logger`,
  `internal = TRUE`). Base fields: `target_entity` (dynamic_entity_reference), `severity` (int,
  RFC log level), `message` (string_long), `context` (map), `created`, `uid` (owner).
- Service `entity_logger` (`EntityLogger`) with `log(EntityInterface, message, context, severity,
  logger_channel)`; only logs for entity types listed in `entity_logger.settings:enabled_entity_types`.
- `entity_logger.instance` (`EntityLoggerInstance`) + `entity_logger.instance.factory`
  (`EntityLoggerInstanceFactory::get()`) for fluent per-entity logging with severity helpers.
- Logger channel `logger.channel.entity_logger`.
- Hooks live in `src/Hook/` (attribute-based, dispatched from `entity_logger.module` via
  `#[LegacyHook]`): `EntityHooks` (entity_type_alter adds the `entity-logger` link template +
  `entity_operation` "Log" op + `entity_predelete` cleanup), `CronHooks` (retention cleanup),
  `HelpHooks`.
- Per-entity log page: `RouteSubscriber` adds `entity.<type>.entity_logger` routes →
  `EntityLoggerController::log()` renders the `entity_logger` view (`embed_entity_log` display).
- Permissions (`entity_logger.permissions.yml`): `view` / `add` / `edit` / `delete entity log
  entries`, `administer entity log entries`, `administer entity logger` (restrict access).
- Views: config view `entity_logger` (base table `entity_logger`); Views field plugin
  `entity_log_entry_severity_label` (`src/Plugin/views/field/SeverityLabel.php`).
