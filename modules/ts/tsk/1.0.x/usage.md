<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Temporary Storages Killer (TSK) clears stuck or stale Drupal temporary storages — private tempstore, shared tempstore and their key/value-expirable backend — that can otherwise block editing (e.g. a lingering PrivateTempStore lock on an entity form).
---
The base `tsk` module provides a Drush command backed by `TskService::kill()`, which validates the collection name and type (`private`/`shared`), then either deletes all items in a `tempstore.<type>.<collection>` collection or a single item by key, logging the result and throwing typed exceptions on bad input or DB errors. The optional `tsk_admin` submodule adds a config entity (`tsk_entity`) and a UI: routes under `/admin/config/development/tsk` (list/add/edit/delete/kill/kill-all) and report/kill routes under `/admin/reports/tsk` that let an admin browse temporary-storage collections and kill a collection or an individual item.

Security posture: every `tsk_admin` route requires the permission **`administer tsk`**, which is declared `restrict access: true` (a sensitive permission). There are no anonymous, `_access: 'TRUE'` or `access content` routes, and the kill/kill-collection/kill-item controllers — although they take `collection`/`type`/`key` as URL arguments — are all behind that admin permission, so an operator is deleting only tempstore data they are already authorized to manage. The base module has no web surface at all (Drush only). Deletion is destructive (users lose unsaved work in the cleared tempstore), so use targeted collection/key kills where possible.
---
- Kill a stuck private tempstore collection via Drush.
- Clear a shared tempstore collection blocking an entity form.
- Delete a single tempstore item by collection/type/key.
- Remove all items in a named tempstore collection.
- Free an entity locked by a lingering PrivateTempStore lock.
- Browse temporary-storage collections at /admin/reports/tsk (tsk_admin).
- Kill a collection from the admin report UI.
- Kill an individual tempstore item from the UI.
- Define reusable TSK config entities for common targets (tsk_admin).
- Add/edit/delete TSK entities at /admin/config/development/tsk.
- Trigger a per-entity "kill" or "kill all" action from the UI.
- Grant the restricted `administer tsk` permission to trusted admins only.
- Script tempstore cleanup in a deployment routine.
- Clear expired key/value-expirable entries for a collection.
- Recover from abandoned multi-step form state.
- Validate collection/type input before deletion (private|shared).
- Log successful and failed tempstore deletions.
- Handle missing keys/collections via typed exceptions.
- Clean up developer/test tempstore clutter.
- Use the Drush command in CI to reset tempstore between runs.
