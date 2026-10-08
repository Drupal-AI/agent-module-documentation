<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Access adds config-driven per-field access control via the entity field access system.

---

Field Access provides configurable access control for entity fields: site builders define, per field, which roles/permissions may view or edit it, and the module enforces this through an AccessHandler wired into the entity field access system (`hook_entity_field_access`). Because it uses the authoritative field-access API, the restriction applies across form, view, REST/JSON:API and programmatic access — not just forms.

The AccessHandler returns `AccessResult::forbidden()` when a field is denied (and neutral otherwise), which is the correct fail-safe pattern for the field access system. Supports Drupal 9, 10, and 11.

---

- Provide per-field access control.
- Configure view/edit access per field.
- Enforce via the field access system.
- Use `hook_entity_field_access`.
- Apply across form/view/REST/JSON:API.
- Not be form-only.
- Return `forbidden()` when denied.
- Return neutral otherwise.
- Follow the fail-safe pattern.
- Support Drupal 9, 10, and 11.
- Restrict sensitive fields.
- Configure by role/permission.
- Enforce authoritatively.
- Cover programmatic access.
- Gate field visibility.
- Gate field editing.
- Use an AccessHandler.
- Protect field data consistently.
