<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extended Logger (extended_logger) — agent index

A PSR-3 logger (service `extended_logger.logger`, tagged `logger`) that renders every Drupal
log record as a single-line JSON object and writes it to a configurable local target:
stdout/stderr (containers), a file, syslog, the database, or nowhere. You pick which fields go
into the JSON, can attach free-form `metadata`, and can use JSONPath placeholders in messages.
It is an *additional* logger — it runs alongside dblog/syslog unless you uninstall those.

- Requirements: PHP >= 8.0, core `^9.4 || ^10 || ^11`; composer libs `adhocore/json-fixer`
  (safely truncate long JSON lines) and `softcreatr/jsonpath` (JSONPath placeholders).
- Configure route: `extended_logger.settings` → `/admin/config/development/extended-logger`
  (route requires permission `administer extended_logger configuration`, see below).
- No drush commands. Defines a config schema (`extended_logger.settings`). Defines no plugin
  types and no permissions of its own.
- Resolved release: **1.3.0-beta2** (no stable release exists on any branch of this project).

## What you'd do → doc

- **Choose the output target and which JSON fields to log** → [configure/settings.md](configure/settings.md)
- **Store logs in the database + browse them in a Views table + auto-cleanup** (submodule `extended_logger_db`) → [configure/database.md](configure/database.md)
- **Attach custom metadata / structured fields, use JSONPath placeholders, log from code** → [api/logging.md](api/logging.md)
- **Alter or enrich a log entry before it is written (subscriber)** → [events/log-event.md](events/log-event.md)

## Key facts (machine names)

- Service: `extended_logger.logger` (`Drupal\extended_logger\Logger\ExtendedLogger`, implements `Psr\Log\LoggerInterface` + `RfcLoggerTrait`).
- Message parser service: `Drupal\extended_logger\Logger\ExtendedLogMessageParser` (extends core `LogMessageParser`).
- Entry model: `Drupal\extended_logger\ExtendedLoggerEntry` (implements `ExtendedLoggerEntryInterface`); serialized with `json_encode()` via `__toString()`.
- Event: `Drupal\extended_logger\Event\ExtendedLoggerLogEvent` (dispatched before persist unless `skip_event_dispatch`).
- Config object: `extended_logger.settings`. Keys: `fields` (sequence), `fields_all`,
  `entry_exclude_empty`, `service_name`, `target` (`output`|`file`|`syslog`|`database`|`none`),
  `target_output_stream` (`stderr`|`stdout`), `target_file_path`, `target_syslog_identity`,
  `target_syslog_facility` (int), `log_line_max_length` (int, min 255 / null), `backlog_items_limit`
  (int / null), `skip_event_dispatch`.
- Permission string used on routes: `administer extended_logger configuration` (the module does
  not ship a `*.permissions.yml` — see configure/settings.md).
- Submodules: `extended_logger_db` (database target + Views log page, deps `views`),
  `extended_logger_fallback` (brings JSONPath placeholders to ALL core loggers by overriding
  `logger.log_message_parser`).
