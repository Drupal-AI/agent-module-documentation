<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Access Entity Type restricts which entity types (and, via its bundled det_node submodule, which content types) are usable on each Domain, based on per-bundle domain assignments.

---

Domain Access Entity Type is a small framework for the Domain (drupal/domain) module that lets you scope entity-type administration and use to specific domains in a multi-domain / affiliate-sites install. The base module provides only a shared bypass service (`DomainEntityTypeManager`) and one global permission — the concrete, per-entity-type behavior lives in submodules. It ships one submodule, det_node (Domain Content Type Access), which is installed automatically and adds a "Domain access" checkboxes group to the content-type add/edit form (stored as a `det_node`/`domains` third-party setting on the `node_type` config entity). When a content type is assigned to one or more domains, det_node restricts that content type's list-builder row, its add-page card, and its node add/edit/delete and content-type edit/delete/permissions routes to those domains only. A content type with no domains selected is available on all domains. Two permissions grant a bypass: `bypass all entity types domain access check` (base module, all entity types) and `bypass content type domain access check` (det_node, content types only). Note the module governs access to entity *types* — it does not restrict viewing of individual published content items; pair it with Domain Access node grants or drupal/domain_entity if you also need per-item content access.

---

- Make a content type (e.g. "Press release") available for authoring only on one domain in a multi-domain install.
- Run several affiliate sites from one Drupal codebase and give each domain its own set of usable content types.
- Hide domain-specific content types from the *Content types* admin list (`/admin/structure/types`) when browsing on a domain they are not assigned to.
- Hide domain-specific content types from the "Add content" page (`/node/add`) on domains where they do not apply.
- Block node creation of a domain-restricted content type on the wrong domain (the `node.add` route).
- Block editing or deleting nodes of a domain-restricted content type when browsing on a non-assigned domain.
- Block editing, deleting, or managing permissions of a content type from a domain it is not assigned to.
- Assign a content type to multiple domains at once via the "Domain access" checkboxes on the content-type form.
- Leave the domain checkboxes empty to keep a content type globally available on every domain (the default).
- Grant editors a per-domain content-authoring experience without writing custom access code.
- Give a trusted role `bypass content type domain access check` so it can manage all content types regardless of the active domain.
- Give a super-admin role `bypass all entity types domain access check` to bypass domain checks for every entity type the framework covers.
- Build a base for additional per-entity-type domain restrictions by reusing the shared `domain_entity_type.manager` service in your own submodule.
- Keep content-type domain assignments in configuration so they can be exported and deployed with `drush config:export`.
- Combine with Domain Access node grants (or drupal/domain_entity) so both the content type and the individual content are scoped by domain.
- Present each affiliate editor with a shorter, relevant content-type list to reduce mistakes.
- Enforce editorial separation between brands/domains that share one Drupal install.
