<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Access Entity extends the Domain module's per-domain access model from nodes to any fieldable entity type. It adds a `domain_access` entity-reference field to the entity types you enable and filters access and entity queries so each entity is only visible on the domain(s) it is affiliated with.

---

Domain (and its `domain_access` submodule) natively restricts *nodes* to specific affiliate domains. Domain Access Entity generalises that to any fieldable entity — taxonomy terms, media, users, custom entities, menu links, etc. From an admin UI at `/admin/config/domain/entities` you tick which entity types should be domain-aware; enabling one creates a multi-value `domain_access` entity-reference field (target type `domain`, cardinality unlimited) on that entity type via the `domain_entity.mapper` service. Per bundle you then choose an assignment **behavior**: `auto` (newly created entities are silently affiliated to the current domain, no widget) or `user` (an options-buttons widget lets the editor pick domains), plus optional excluded routes; these are stored in the field's `third_party_settings.domain_entity`. At runtime the module's `query_alter`, `entity_access`, `entity_create_access` and `entity_presave` hooks enforce the rule: an entity is accessible only on the domains it references (an entity with no domain is treated as affiliated to all). Static permissions let trusted editors work across their assigned domains, and dynamic per-bundle create/update/delete permissions mirror Domain Access's node permissions. A global `bypass_access_conditions` setting can disable the query filtering for troubleshooting. The bundled **Domain Menu Access** submodule applies the same treatment to menu links. The module also ships a "domain source" path processor that can rewrite an entity's outbound URLs to its canonical domain.

---

- Restrict taxonomy terms so each term only appears on the affiliate domain(s) it belongs to.
- Make media items domain-specific in a multi-domain (affiliate) Drupal install.
- Give custom content entities the same per-domain access that Domain gives nodes.
- Auto-assign every entity created on a domain to that domain, with no widget shown to the editor.
- Let editors explicitly choose which domains an entity is published to via an options-buttons widget.
- Filter entity listing queries so users only see entities affiliated to the current domain.
- Allow a multi-domain editor (with the right permission) to see/edit entities across their assigned domains in admin.
- Create per-bundle "create/update/delete on assigned domains" permissions for delegated domain editors.
- Treat entities with no domain assignment as available on all domains (fallback behavior).
- Enable domain access on several entity types at once from a single tableselect admin form.
- Disable the module's access filtering temporarily (`bypass_access_conditions`) to troubleshoot a view or query.
- Exclude specific routes from domain-source URL rewriting per bundle.
- Rewrite an entity's outbound links to point at its canonical/source domain (domain source behavior).
- Build affiliate sites that share one Drupal install but scope content per brand/region.
- Add the `domain_access` field programmatically to an entity type with the `domain_entity.mapper` service.
- Remove domain access from an entity type again by deleting its `domain_access` field storage.
- Combine with Domain Access on nodes for a consistent per-domain model across all content.
- Expose the domain field in Views to let editors filter entities by domain (disable SQL rewrite where needed).
- Scope menu links per domain using the Domain Menu Access submodule.
- Set a default domain value for new entities via `domain_entity_field_default_domains`.
- Gate cross-domain visibility behind the restricted `access entities affiliate on assigned domains` permission.
- Ensure entities migrated without a domain assignment don't silently become inaccessible.
- Manage per-bundle assignment behavior (auto vs user) independently for each bundle of an enabled entity type.
