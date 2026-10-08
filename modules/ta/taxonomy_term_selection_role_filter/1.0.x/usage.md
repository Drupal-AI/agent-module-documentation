<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Term Selection Role Filter filters term selection lists based on a user role reference field on the term.

---

Taxonomy Term Selection Role Filter **limits which taxonomy terms a user can select** — each term can
carry a **role-reference field**, and this module filters term selection lists so a user is only offered terms
whose referenced roles they hold. This lets you scope vocabularies by role (e.g. department-specific terms). It
depends on core Taxonomy.

Use it to present role-appropriate term choices. It is an access-adjacent content-editing feature: note it
governs **what appears in the selection widget** (a UI/authoring convenience), which is **not** a hard
security boundary on the term data itself — do not rely on it to protect term visibility elsewhere (the terms
still exist and may be reachable by other means). It has no entity-access-control role. Configure the term
role-reference field and the filter.

---

- Filter selectable terms by user role.
- Use a role-reference field on terms.
- Offer only role-matching terms.
- Scope vocabularies by role.
- Depend on core Taxonomy.
- Present role-appropriate choices.
- TREAT it as a selection-UI filter, not a hard boundary.
- Not rely on it for term visibility elsewhere.
- Know the terms still exist/are reachable.
- Have no entity-access-control role.
- Configure the role-reference field.
- Handle term filtering.
- Filter term lists.
- Configure the filter.
- Scope term selection.
- Limit term choices.
- Handle role filtering.
- Filter selection.
- Configure roles.
- Provide role-based term filtering.
