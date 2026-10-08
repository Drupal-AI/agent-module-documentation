<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Access by Reference Field (entity_access_by_reference_field) — agent index

Controls entity access by the user's access to entities it **references** (per-field permission
matrix, ANY/ALL for multiple refs, delegates to `$referencedEntity->access()`). Version **1.1.0**.
Core `>=10.2`. Global bypass perm `bypass entity_access_by_reference_field permissions`.

**CRITICAL — it fails open by default.** On a failed reference check it returns the field's
`access_fallback`, which **defaults to Neutral** → does NOT deny → core `access content` still
grants. **Enabling the field setting alone does not restrict anything.** To actually restrict, set
the field's fallback to **Forbidden**. (Neutral-default is idiomatically correct for
hook_entity_access, but the name invites the wrong assumption.)

Minor: `is_referenced_user` also grants on delete-access to the referenced entity.