<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Role Widget is an addon for user reference fields.

---

User Role Widget provides field widgets (select list, checkbox, autocomplete) and an entity-reference
selection plugin for **user-reference fields** — letting you present/filter the referenceable users by role
(so a reference field can offer users of a specific role). It depends on core Field.

Use it to build user-reference widgets scoped by role. It is a content-editing/reference-widget feature; the
referenceable users are governed by the field's **selection handler and entity access** (the widget presents
users the field is configured to allow), and it does **not** itself grant the ability to assign users/roles —
that remains governed by the field's own access and, for the user roles field specifically, core's
role-assignment permissions. It has no access-control role. Configure the widget on the user-reference
field.

---

- Provide widgets for user-reference fields.
- Filter referenceable users by role.
- Offer select/checkbox/autocomplete widgets.
- Depend on core Field.
- Present users of a specific role.
- Scope references by role.
- Govern referenceable users by selection handler + entity access.
- Not grant assigning users/roles itself.
- Rely on the field's access (and core role-assignment for roles).
- Have no access-control role.
- Configure the widget on the field.
- Handle user-reference widgets.
- Filter users by role.
- Configure the widget.
- Present users by role.
- Handle reference widgets.
- Scope user references.
- Configure references.
- Provide role-scoped widgets.
- Reference users by role.
