<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Access ("adva") is an entity-agnostic access-control **API**: it generalizes Drupal core's node-grant system (realms + grant IDs, per-entity access records) to any entity type through two plugin types — **Access Providers** (compute grants/records) and **Access Consumers** (enable adva for an entity type). Submodules apply it to nodes (`adva_na`) and media (`adva_media`).

---

The module defines an `adva_access` grant table mirroring core's `node_access` (columns entity_type/entity_id/langcode/realm/gid/grant_view/grant_update/grant_delete). **Access Provider** plugins (`Plugin/adva/AccessProvider`, e.g. the built-in `anonymous` provider) declare which grants a user holds (`getAccessGrants`) and which access records an entity gets (`getAccessRecords`). **Access Consumer** plugins (`Plugin/adva/AccessConsumer`) enable adva for one entity type; a *basic* consumer only exposes provider configuration, while an *overriding* consumer additionally replaces the entity type's access control handler with `AdvancedAccessEntityAccessControlHandler` and stores/queries records in `adva_access`. At `/admin/config/people/adva` (`adva.settings`, permission `administer adva`) you pick which providers are enabled per consumer and configure them; saving clears and requeues that entity type's records (rebuilt over time via a queue worker, or immediately via "Save and Update Access Records" / the `/rebuild/{consumer}` form). Records update automatically on entity insert/update/delete. Listing queries are filtered through `hook_query_alter` (joining `adva_access`); direct entity access goes through the overriding handler. Two permissions gate bypass: `bypass adva access` (global) and per-entity `bypass adva <type> access`. A `search_api` processor (`AdvancedAccess`) applies grants to indexed content. Provides plugin managers, config schema, permissions, a param converter, batch + queue workers; no Drush.

---

- Add per-entity view/update/delete access control to a custom entity type (write an Access Consumer).
- Grant access based on a new dimension (department, subscription, ownership) via an Access Provider.
- Restrict node visibility using adva's node-grant bridge (`adva_na`).
- Restrict media entity access with `adva_media`.
- Expose selected content to anonymous users through the built-in `anonymous` provider.
- Reuse core's realm/grant model for non-node entities without writing node-access code.
- Filter Views/EntityQuery listings to only entities a user has grants for (via query alter).
- Give site builders a UI to toggle which access providers apply to each entity type.
- Rebuild an entity type's access records after changing provider configuration.
- Rebuild permissions in the background via the queue worker instead of one long batch.
- Grant a "bypass" permission to trusted roles to see all content of an entity type.
- Integrate access grants into Search API indexes so search respects them.
- Combine several providers on one entity type (grants merge across providers).
- Override an entity type's access handler while still honoring its original/legacy handler.
- Add language-aware grants (records carry langcode + fallback) on multilingual sites.
- Provide contextual/reference-based access via the reference/entity-type provider base classes.
- Model bundle-level and default operation grants (the anonymous provider supports per-bundle overrides).
- Trigger a node_access rebuild automatically when node provider config changes (`adva_na`).
- Build an example/reference access provider quickly (see the hidden `adva_example_provider`).
- Centralize cross-entity access logic in one pluggable API instead of scattered hook_*_access.
