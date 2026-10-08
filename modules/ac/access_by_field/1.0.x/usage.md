<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Entity by Field Value restricts view/update/delete of nodes and taxonomy terms by comparing a shared field between the user and the entity.

Use it when you want per-user content visibility driven by a reference/boolean field (e.g. a user's "region" term must intersect a node's "region" terms) without writing a custom node-access module.

- Implements `hook_entity_access()` for `node` and `taxonomy_term` only.
- Maps one entity field to one user field per bundle via an admin UI.
- Grants access when the user's and the entity's field target_ids intersect.
- Supports revoking `create`, `view`, `update`, `delete` per mapping.
- Lets selected roles (default: administrator) bypass all restrictions.

---

Install and configure:

- Enable the module (`drush en access_by_field`).
- Grant the `access abf mapping settings page` permission to trusted admins only.
- Visit `/admin/config/access-by-field` to reach the config menu.
- Add a mapping at `/admin/config/access-by-field/fields-mapping/{type}/{bundle}` selecting the entity field, user field, and revoked operations.
- Configure bypass roles at `/admin/config/access-by-field/bypass-role`.
- Review all mappings on the Mapping Dashboard (`/admin/config/access-by-field/mapping-list`).

---

- Create a user field and an entity field of the same reference/boolean type.
- Map them so the module can compare `target_id` values.
- For `view`, access is allowed only if the user and entity share at least one target_id.
- For `update`/`delete`, the module additionally requires the matching core permission (`update any/own X content`, `delete terms in X`).
- Bundles with no field access tags are skipped (no restriction added).
- Users with a bypass role short-circuit the check and are always allowed.
- The administrator role is bypassed by default when no bypass config exists.
- Mapping configuration is stored in `abf_fields_mapping.settings`.
- Bypass configuration is stored in `abf_bypass_roles.settings`.
- Only `entity_reference` and `boolean` fields with a target bundle are offered for mapping.
- The dashboard lists label, entity type, bundle, fields, and revoked operations.
- Delete a mapping via the confirm form at `.../{bundle}/delete`.
- Note: the module returns `AccessResult` without per-user cache metadata, so pair it with appropriate cache settings for correctness.
- Works alongside core node grants; a `forbidden` result from this module overrides other `allowed` results.
- Best used for coarse, field-driven segmentation rather than fine-grained ACLs.
- Test each mapping as a non-privileged user before relying on it.
