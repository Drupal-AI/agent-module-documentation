<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Entity by Field Value — agent orientation

Adds field-value-based entity access for `node` and `taxonomy_term` via `hook_entity_access()`.

Key files:
- `access_by_field.module` — `access_by_field_entity_access()` and `_access_by_field_override_permissions()` hold the whole access decision.
- `src/Form/AbfFieldsMappingForm.php` — maps an entity field to a user field per bundle.
- `src/Form/AbfBypassRoleForm.php` — roles that bypass restrictions.
- `src/Controller/MappingDashboardController.php` — lists mappings.

How it decides: loads mapping for the entity bundle from `abf_fields_mapping.settings`, compares user field target_ids against entity field target_ids; intersection => allowed, else forbidden. Bypass roles (default administrator) return neutral/allowed.

Gotchas:
- Only reference/boolean fields with a target bundle are mappable.
- `AccessResult` objects lack `cachePerUser()` metadata — a correctness caveat for render/page caching.
- Admin routes all require `access abf mapping settings page`.
