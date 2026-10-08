<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Collection groups content and configuration entities into managed collections with ownership and access.

---

Collection lets you group content and configuration entities into named collections — with owners, per-collection membership, and landing/overview pages — so a site can model sub-sites, portfolios, or curated sets of entities. It builds on dynamic_entity_reference and inline_entity_form.

Permissions are granular: administration (`administer collections`, `administer users in collections`), an overview (`access collection overview`), and owner-scoped `view own`/`edit own`/`delete own collections`. The `administer` permissions are powerful — restrict to trusted roles. Depends on `dynamic_entity_reference`, core `path`, `inline_entity_form`, and `key_value_field`; supports Drupal 9.4, 10, and 11.

---

- Group entities into collections.
- Include content and config entities.
- Assign collection owners.
- Manage per-collection membership.
- Provide landing/overview pages.
- Model sub-sites/portfolios.
- Gate admin with `administer collections`.
- Gate user management with `administer users in collections`.
- Gate overview with `access collection overview`.
- Scope `view/edit/delete own collections`.
- Restrict admin permissions to trusted roles.
- Depend on `dynamic_entity_reference`, `inline_entity_form`.
- Depend on core `path` and `key_value_field`.
- Support Drupal 9.4, 10, and 11.
- Curate entity sets.
- Support owner-scoped access.
- Build curated collections.
- Manage collection membership.
