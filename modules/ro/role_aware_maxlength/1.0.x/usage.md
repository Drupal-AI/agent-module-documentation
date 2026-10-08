<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enforce per-role character limits on text fields.

---

Role-aware maxlength enforces different character limits on text fields based on the current user's roles — limits are configured per field instance and enforced server-side via a typed-data constraint, with a field widget enhancement providing a live character counter in forms. So editors in different roles can have different maximum lengths on the same field. Depends on core `field` and `user`; supports Drupal 11.3+.

---

- Enforce per-role character limits.
- Configure limits per field instance.
- Enforce server-side (typed-data constraint).
- Show a live character counter.
- Vary limits by user role.
- Depend on core `field` and `user`.
- Support Drupal 11.3+.
- Configure the limits.
- Aid editorial governance.
- Handle maxlength.
- Limit field length.
- Count characters
- Support Drupal.
- Support Drupal.
- Support Drupal.
