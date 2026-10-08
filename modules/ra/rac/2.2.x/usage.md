<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Access Control (RAC) expresses "only these roles may view/update/delete this content" as node/entity access **grants** built on **ADVA** (Advanced Access), so per-role access becomes a query-level grant rather than a bespoke node-access implementation. A `user_role` entity-reference field on a bundle names the allowed roles; RAC maps role membership to a grant.

---

RAC 2.x is a thin, role-shaped policy layer over ADVA: it contributes three ADVA `@AccessProvider` plugins and lets ADVA do the enforcement. `rac` (`RoleAccessProvider`) reads a role-reference field and authorises any user who holds one of the referenced roles; `rac_typed` (`EntityTypeRoleAccessProvider`) drops the field and instead grants access to roles chosen per entity type/bundle in ADVA's config; and the `rac_relations` submodule (`RoleAccessControlRelationsProvider`) authorises by *related* roles configured in a role-by-role grid at `/admin/config/people/rac/relations`, so one role can edit another role's content without holding it. Per-role permissions (`RAC_view_<id>`, `RAC_update_<id>`, and the submodule's `RAC update <id>`) are generated at runtime by `permission_callbacks` and mostly managed programmatically rather than on the permissions page. Because it sits on the grants system, RAC covers listings, Views and search — but grants are OR-combined across modules and node access must be rebuilt after configuration changes on an existing site. Its `configure` route points at `adva.settings`, signalling that ADVA is where access is actually switched on. Core requirement is `^9 || ^10 || ^11 || ^12`, spanning Drupal 12.

---

- Restrict content visibility to specific roles.
- Give a members-only role access to premium content.
- Hide internal documents from anonymous users.
- Express role-based access as node access grants.
- Avoid writing a custom node-access module.
- Restrict a whole content type to staff roles via `rac_typed` bundle config.
- Let editors update content belonging to another role via relations.
- Combine role access with ADVA's other access providers.
- Model a subscriber-only content tier.
- Keep view/update/delete access decisions in configuration.
- Support an intranet's role structure for content.
- Grant view access per role and per bundle.
- Reuse ADVA's grant machinery instead of reimplementing grants.
- Restrict a document library by department role.
- Enforce access consistently in listings and search.
- Mirror a Taxonomy Access Control setup using roles instead of terms.
- Prepare a role-based node-access setup for Drupal 12.
- Replace a bespoke grants implementation with configuration.
- Delegate cross-role editing rights through a relations grid.
- Apply role access to paragraphs or other fieldable entities with an ADVA consumer.
- Add a role-reference field and mark it as an access field.
- Rebuild node access after changing role-access configuration.
