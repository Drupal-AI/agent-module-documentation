<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Guard enforces fail-closed per-field access, denying with an unoverridable forbidden().

---

Field Guard provides config-driven per-field access control that fails closed: when a field is guarded, it denies access with `AccessResult::forbidden()` via `hook_entity_field_access` — a result that no permission, admin role, or even user 1 can override. This makes it suitable for hard-locking sensitive fields regardless of role.

Because forbidden is absolute here, configure guarded fields carefully — even administrators lose access. Enforcement is through the authoritative field-access system, so it applies across form, view, REST/JSON:API and programmatic access. Depends on core `field` and `user`; supports Drupal 10.6+, 11.3+, and 12.

---

- Provide fail-closed field access.
- Deny with `AccessResult::forbidden()`.
- Make denial unoverridable.
- Block even admin/user 1.
- Enforce via `hook_entity_field_access`.
- Apply across form/view/REST/JSON:API.
- Hard-lock sensitive fields.
- Configure guarded fields carefully.
- Note admins also lose access.
- Depend on core `field` and `user`.
- Support Drupal 10.6+, 11.3+, and 12.
- Use config-driven rules.
- Protect fields absolutely.
- Cover programmatic access.
- Fail closed by design.
- Guard field visibility/edit.
- Enforce authoritatively.
- Lock down field data.
