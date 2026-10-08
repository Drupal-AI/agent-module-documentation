<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Collector — agent orientation

Content-entity based "collections" with AJAX/no-JS add/remove endpoints.

- Version 3.0.x, core ^8.8||^9||^10. Provides `entity_collection` entity + full permission set (`entity_collector.permissions.yml`).
- All action routes use `_custom_access` → `EntityCollectionActionController::checkUpdateAccess`/`checkViewAccess`, which call `$entityCollection->access('update'|'view', $account)`. Collection-level access enforced. Locks per collection.
- Note: add/remove take an arbitrary `{entityId}` and store the reference without checking view access on the *target* entity, but rendering applies access; no direct disclosure in this module. Access model looks sound.
