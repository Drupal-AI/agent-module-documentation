<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent entity unpublish (prevent_entity_unpublish) — agent index

**Blocks unpublishing a node/term/user while other entities reference it (referential integrity for publish state).**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Machine name:** `prevent_entity_unpublish` (project/dir `prevent_entity_unpublished`).
- **Dependencies:** entity_reference_integrity, entity_reference_integrity_enforce.
- **Route/permission:** `prevent_entity_unpublish.settings` (`/admin/config/content/prevent-entity-unpublish`) requires `administer prevent entity unpublish` (`restrict access: true`).
- **Config:** `prevent_entity_unpublish.settings:enabled_entity_type_ids`.
- **Mechanism:** `hook_form_alter` adds `form_validation_published_content`; on status=0 it delegates to `EntityPreupdate::entityUpdate`, which sets a form error when the entity has dependents.
- **Security:** admin-config route only, permission-gated; no anonymous or mutating endpoints. Enforcement is a form-validation guard (blocks the UI save path), not a low-level entity API hook — programmatic saves are not intercepted.

See [configure/settings.md](configure/settings.md)
