<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TSK — killing temporary storages

## Service API
`\Drupal::service('tsk')->kill(string $collection, string $type = 'private', bool $kill_all = TRUE, string $key = '')`
- `type` must be `private` or `shared` (else `InvalidTempstoreTypeException`).
- `kill_all = TRUE` → `deleteAll()` on `tempstore.<type>.<collection>`.
- `kill_all = FALSE` requires a non-empty `$key` → deletes that single item.
- Empty collection → `InvalidArgumentException`; DB failures → `TempstoreDatabaseException`; missing key → `TempstoreKeyNotFoundException`.

## Drush
Base command in `src/Commands/TskCommands.php`; `tsk_admin` adds `TskAdminCommands`. Use them to clear stuck tempstore that blocks entity edit forms.

## Admin UI (tsk_admin submodule) — all require `administer tsk`
- `/admin/config/development/tsk` — list/add/edit/delete `tsk_entity` config entities; `/{tsk_entity}/kill` and `/kill-all` actions.
- `/admin/reports/tsk` — list live temporary-storage collections.
- `/admin/reports/tsk/kill/{collection}/{type}` — kill a whole collection.
- `/admin/reports/tsk/kill-item/{collection}/{type}/{key}` — kill one item.

## Cautions
`administer tsk` is `restrict access: true` — grant to trusted admins only. Deletion is irreversible and discards users' unsaved work in the affected tempstore; prefer targeted collection/key kills.
