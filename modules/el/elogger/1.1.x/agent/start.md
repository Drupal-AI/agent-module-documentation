<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Logger (elogger) — agent index

Records Drupal system events as **`elog` content entities** (base table `elog`). Hooks into
every entity create/update/delete and every form submission, stores a token-formatted message,
an entity **diff** (for updates), the serialized **form values** (for submissions), plus the
requester IP and User-Agent. Can additionally forward each event to **watchdog/dblog or raw
syslog**. Browse/export the log through a bundled Views listing; cron prunes old rows.

Depends on core `token`* and `views`, plus contrib `views_data_export`, `views_bulk_operations`
and `diff`. Core requirement `^9 || ^10 || ^11`. (*token is contrib but core-adjacent.)

Configure route: **`elogger.system`** → `/admin/config/system/elogger`. Defines permissions and a
config schema; no drush, no plugin types.

- **Configure what is tracked, message templates, retention, and syslog output** → [configure/configuration.md](configure/configuration.md)
- **Log an event from your own code (the `elogger.logger` service) + what gets stored** → [api/logger.md](api/logger.md)
- **The automatic hooks (entity CRUD + form-submit logging, diff capture, cron prune)** → [hooks/automatic-logging.md](hooks/automatic-logging.md)
- **Permissions and entity access** → [permissions/permissions.md](permissions/permissions.md)
- **The log listing + CSV export view, and the `elog` entity fields** → [views/listing.md](views/listing.md)

Key facts:
- Config object: **`elogger.settings`**. Keys: `format`, `output_type`, `modules`, `actions_forms`,
  `log_message_templates` (`entity_create`/`entity_update`/`entity_delete`/`actions`),
  `elogger_row_limit`, `elogger_text_format`.
- Services: **`elogger.logger`** (`Drupal\elogger\Services\Elogger`) — the API; **`logger.eventlog`**
  (`Drupal\elogger\Logger\EventLog`) — the syslog/watchdog forwarder.
- Entity: **`elog`**, base table `elog`, canonical `/admin/reports/elogger/elog/{elog}`.
- Permissions: `administer event log entity`, `view event log entity`, `delete event log entity`,
  `administer elogger configurations`.
- Routes: `elogger.system` (`/admin/config/system/elogger`, filters), `elogger.system.log_messages`,
  `elogger.system.settings`, `elogger.elog_settings` (`/admin/structure/elog`, entity/field-UI base).
- Views: id `elogger`, page display `elogs` at `/admin/reports/elogger`, data-export display
  `eloger_export` (`elogger.csv`).
- Provides an **`elogger`** token type (`hooks/automatic-logging.md` / `api/logger.md`).
