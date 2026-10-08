<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk delete flow

No settings to configure — the module *is* a two-step delete form. There is no config schema; the
only shipped config is `entity_delete.entitydeleteconfirmation` (button labels).

## Step 1 — select (`EntityDeleteForm`, route `entity_delete.entity_delete_bulk`)
Path `/admin/config/entity-delete`. Fields:
- `entity_type` (required select) — every `ContentEntityType` definition, by label. AJAX-driven.
- `type` (select) — bundle options for the chosen entity type, plus `all`. Rebuilt via AJAX
  (`ajaxCallChangeEntity`). `comment` shows no bundle (unsupported), just a note.

Submit builds a `Url` to the confirmation route with `entity_type` and `bundle` as **query
parameters**, attaches a CSRF token to the path, and redirects.

## Step 2 — confirm (`EntityDeleteConfirmationForm`, route `entity_delete.entity_delete_confirmation`)
Path `/admin/config/entity-delete/confirm`, requires `_csrf_token: 'TRUE'`. Reads `entity_type` /
`bundle` from `$request->query`. On **Confirm**:

- **Log entries:** `entity_type == 'watchdog'` && `bundle == 'all'` → `Database::truncate('watchdog')`
  (clears the dblog table directly; no entity query).
- **Users:** `users` is remapped to `user`; the query adds `condition('uid', [0, 1], 'NOT IN')` so
  the anonymous (0) and admin (1) accounts are never deleted.
- **Files:** `file_managed` is remapped to `file`.
- **Bundle scoping:** for entity types not in `['file','comment','user','watchdog']`, it looks up the
  bundle entity key and, when `bundle != 'all'`, adds `condition(<bundle_key>, $bundle)`.
- Matched IDs are chunked with `array_chunk($ids, 25)`; each chunk becomes a batch operation calling
  `DeleteEntity::deleteEntities()` (`storage->delete(loadMultiple($chunk))`). Finish callback
  (`deleteEntityFinishedCallback`) prints "Successfully deleted N …".
- **Cancel** (`op == 'Cancel'`) or zero matches → redirect back to the select form with a message.

## Notes / gotchas
- `DeleteEntity::deleteEntities()` and the finished callback are `public static` methods used as batch
  callbacks (`\Drupal\entity_delete\DeleteEntity::…`).
- Deletion goes through normal entity storage `delete()` (invokes hooks, deletes translations),
  **except** `watchdog` which is a raw SQL truncate.
- No dry-run and no undo. Intended for trusted admins (permission is `restrict access: TRUE`).
