<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logging API (entity_logger)

How code writes log entries against an entity. Source: `src/EntityLogger.php`,
`src/EntityLoggerInstance.php`, `src/EntityLoggerInstanceFactory.php`, interfaces of the same names,
`src/Event/*`. Services declared in `entity_logger.services.yml`.

## Services

- **`entity_logger`** → `EntityLogger` (autowired). Also aliased to the interface
  `Drupal\entity_logger\EntityLoggerInterface`.
- **`entity_logger.instance`** → `EntityLoggerInstance` (aliased to `EntityLoggerInstanceInterface`).
  A stateful, fluent per-entity logger.
- **`entity_logger.instance.factory`** → `EntityLoggerInstanceFactory`. Preferred entry point: hands
  back a configured instance for a specific entity/channel.
- **`logger.channel.entity_logger`** → a `logger.channel_base` child named `entity_logger` (used by
  `CronHooks` and available as an optional mirror channel).

## `EntityLogger::log()`

`log(EntityInterface $entity, string $message, array $context = [], int $severity = RfcLogLevel::INFO, ?string $logger_channel = NULL): ?EntityLogEntryInterface`

1. Reads `entity_logger.settings:enabled_entity_types`. If `$entity->getEntityTypeId()` is **not** in
   that list, returns `NULL` and stores nothing (logging is opt-in per entity type).
2. Runs the message through `LogMessageParserInterface::parseMessagePlaceholders()` so PSR-3
   placeholders (`@x`, `%x`, `:x`) in `$message` are resolved from `$context`.
3. Creates an `entity_log_entry`, sets target entity, message+context, severity, and `save()`s it.
4. If `$logger_channel` is given, also logs the same message/severity to that Drupal logger channel.
5. Returns the saved `EntityLogEntryInterface` (or `NULL` when the type is not enabled).

`getAvailableEntityTypesForLogging()` returns the option list used by the settings form: every entity
type with a `canonical` link template, plus any type added by the event below.

## Fluent instance — `EntityLoggerInstance`

Get one from the factory, then chain:

- `EntityLoggerInstanceFactory::get(EntityInterface $entity, ?string $channel = NULL)` sets the entity
  (and optional mirror channel) and returns the shared instance.
- Setters: `setEntity()`, `setLoggerChannel()`.
- Writers (all no-op returning `NULL` if no entity is set), delegating to `EntityLogger::log()`:
  - `addLog()` / `addInfoLog()` → `RfcLogLevel::INFO`
  - `addNoticeLog()` → `NOTICE`
  - `addWarningLog()` → `WARNING`
  - `addErrorLog()` → `ERROR`
  - `addLogWithSeverity($message, $context, $severity)` for an explicit level.

Note: `entity_logger.instance` is a shared service; `factory::get()` mutates and returns that single
instance, so treat it as short-lived within one operation rather than holding references.

## Extending loggable types — the event

`EntityLoggerEvents::AVAILABLE_ENTITY_TYPES` (`'entity_logger.available_entity_types'`) dispatches
`EntityLoggerAvailableEntityTypesEvent`. Subscribe and call `$event->addEntityType('my_type')` to make
an entity type (one without a `canonical` link template) selectable on the settings form.
