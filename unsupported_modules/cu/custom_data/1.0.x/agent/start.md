<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_data — agent orientation

General-purpose fieldable content entity type with config-entity bundles ("custom data types"). Depends on contrib `entity`.

- Types managed at `/admin/structure/custom-data-type`; per-bundle permissions via Entity API permission provider.
- Canonical route `/custom-data/{id}` guarded by `CustomDataController::viewCanonicalAccess` → delegates to `$entity->access('view')`. Sound.
- Perms: `administer custom_data`, `administer custom_data_type` (restricted), `access custom_data overview`.
- Entity queries use `accessCheck(TRUE)`. No external-fetch/mutation surface.
- Read: `src/Controller/CustomDataController.php`, `src/Entity/`, `custom_data.api.php`.
