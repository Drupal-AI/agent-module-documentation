<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Cleanup (module_cleanup) — agent index

A repair toolkit for four specific Drupal leftover-data errors, exposed as an admin page
(four stacked forms) plus five Drush commands, plus a passive logger that self-heals one error.
Core requirement `^8 || ^9 || ^10 || ^11 || ^12`. No config schema, no dependencies.

## What it actually does

One route `/admin/config/system/delete-transient-module-data`
(`ModuleCleanupController::overview`), permission `delete transient module data`, renders four
independent `FormBase` forms:

1. **`TransientModuleDataDeleteForm`** — lists modules that have a schema version
   (`update.update_hook_registry::getAllInstalledVersions()`) but are absent from
   `extension.list.module::getAllInstalledInfo()` (i.e. uninstalled/deleted). Submitting deletes
   `key_value` rows `WHERE name = <module>`. Fix for *"Module 'x' has an entry in the system.schema
   key/value storage"*.
2. **`TransientEntityTypeDeleteForm`** — runs `field_purge_batch(1000)`. On a `FieldException` for a
   field whose storage is gone, it regex-parses the message to recover field name + entity type,
   recreates a temporary `string` `FieldStorageConfig`, and on the next click deletes it so the purge
   completes. State is carried across clicks in a `tempstore.private` ("part_two"/"part_three").
   Fix for *"The 'x' entity type does not exist"*.
3. **`ClearUpdateDeleteForm`** — deletes `key_value` `WHERE collection = 'update_fetch_task'`. Fix for
   *"No available releases found"* on the Available Updates report.
4. **`UpdateConfigEntityForm`** — just calls `drupal_flush_all_caches()`. Only useful together with
   the logger below.

**`ViewerErrorHandler`** (`module_cleanup.services.yml`, tag `logger` priority 100) — implements
`LoggerInterface`; on any log message beginning *"A non-existent config entity name returned by
FieldStorageConfigInterface"* it reads `%entity_type/%field/%bundle` from context and removes that
bundle from the `entity.definitions.bundle_field_map` key_value map, then shows a message. This makes
that error self-heal on cache clear / module install.

## Drush (see `agent/drush/`)

`modcup:field-purge-batch` (`-fpb`), `modcup:create-storage` (`-cs`), `modcup:delete-field` (`-df`),
`modcup:clear-updates` (`-cu`), `modcup:delete-config` (`-dc`). Registered via `drush.services.yml`
(`ModuleCleanupDrushCommands`, arg `@database`).

## Key facts / cautions

- **All operations are irreversible and write straight to `key_value` or field-purge internals.**
  Back up the database first.
- **Deletions match on `key_value` `name` / `collection` only** — no verified ownership of the data.
  Form-1 deletes by `name` across *all* collections (no collection filter); its options list is limited
  to genuinely-uninstalled modules and checkbox values are validated against that list by core.
- Everything is gated by the single `delete transient module data` permission; forms are standard
  Form API so submissions carry a CSRF token.
- `data.json` corrections vs. the old stub: `provides_drush_commands` is **true** (5 commands),
  `provides_config_schema` is **false** (no `config/`).
- Related storage-reclamation modules in this corpus: `orphans_media`, `revision_cleanup`, `cleaner`.

## Files
- `agent/forms/` — the four admin forms, route, permission, logger service.
- `agent/drush/` — the five `modcup:*` commands.
