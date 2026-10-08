<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module Cleanup is an admin utility (plus five Drush commands) for removing data left behind by modules that were uninstalled or deleted, and for fixing the recurring "schema", "entity type does not exist", "no available releases" and "non-existent config entity name" errors those leftovers cause.

---

Despite the "transient data" framing, this is a targeted repair toolkit for four specific, well-known Drupal error conditions rather than a general database cleaner. Enabling it exposes one admin page at `/admin/config/system/delete-transient-module-data` (permission `delete transient module data`) that stacks four independent forms. The first lists modules that still have a `system.schema` entry in the `key_value` table but are no longer installed on disk, and deletes those `key_value` rows by name — the fix for "Module 'module_name' has an entry in the system.schema key/value storage". The second runs core's `field_purge_batch(1000)` and, when it hits a `FieldException` for a field whose storage no longer exists, parses the exception text to recover the field name and entity type, temporarily recreates a `string` field storage so the purge can complete, then deletes it — a guided multi-click fix (state carried in a private tempstore) for "The 'module_name' entity type does not exist". The third deletes the `update_fetch_task` collection from `key_value` to clear "No available releases found" on the Available Updates report. The fourth simply runs `drupal_flush_all_caches()`. That last fix only works in concert with a logger service the module registers at priority 100: `ViewerErrorHandler` watches every log message, and when one begins "A non-existent config entity name returned by FieldStorageConfigInterface", it reads the entity type / field / bundle from the log context and unsets that stale bundle from the `entity.definitions.bundle_field_map` key_value map — so the error self-heals on the next cache clear or module install. The Drush commands (`modcup:*`) cover the same ground for CLI/automation. Everything here writes directly to the `key_value` table or invokes field-purge internals, so the operations are irreversible: take a database backup first, and note that deletions match on the `key_value` `name`/`collection` alone, not on any verified ownership of the data.

---

- Delete a `system.schema` `key_value` row left by an uninstalled module ("Module 'x' has an entry in the system.schema key/value storage").
- Clear the residue of a module directory that was deleted without being uninstalled.
- Run `field_purge_batch(1000)` from an admin form instead of waiting for cron.
- Fix "The 'entity_type' entity type does not exist" by purging an orphaned field.
- Let the module auto-recreate then delete a missing field storage so a stuck field purge can finish.
- Clear "No available releases found" on the Available Updates report (`update_fetch_task` collection).
- Auto-heal "non-existent config entity name returned by FieldStorageConfigInterface::getBundles()" on cache clear.
- Force a full cache flush from the cleanup page.
- Script leftover-config removal with `drush modcup:delete-config <module>`.
- Purge orphaned fields non-interactively with `drush modcup:field-purge-batch`.
- Create a placeholder field storage with `drush modcup:create-storage <field> <entity_type>`.
- Delete an orphaned field and its storage with `drush modcup:delete-field <field> <entity_type>`.
- Clear stale update-fetch data via `drush modcup:clear-updates`.
- Shrink a database dump by dropping orphaned key_value data.
- Tidy a long-lived site before a migration or consolidation.
- Reduce confusion when a previously removed module is later reinstalled.
- Gate all of the above behind the single `delete transient module data` permission.
- Support versions of Drupal from 8 through 12 (core requirement `^8 || ^9 || ^10 || ^11 || ^12`).
- Diagnose which installed module keeps re-emitting the config-entity error (the maintainer notes an installed module is usually the source).
