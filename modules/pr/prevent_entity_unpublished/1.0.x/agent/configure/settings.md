<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Prevent entity unpublish

Prerequisite: enable `entity_reference_integrity` and `entity_reference_integrity_enforce`, then this module.

1. Go to `/admin/config/content/prevent-entity-unpublish` (permission: `administer prevent entity unpublish`).
2. Tick the entity types to protect — only **node**, **taxonomy_term** and **user** are offered.
3. Save. The choice is written to `prevent_entity_unpublish.settings:enabled_entity_type_ids`.

Behaviour:
- On node/term/user edit forms, if the editor sets status to unpublished and the entity has dependents (per `entity_reference_integrity.dependency_manager`), a validation error lists the referencing entities and the save is rejected.
- Enforcement lives in the form `#validate` path only. It does not hook the entity storage layer, so an unpublish performed via code (`$entity->setUnpublished()->save()`), migrations or REST is **not** blocked — treat the guard as UI-level, not an authorization boundary.
