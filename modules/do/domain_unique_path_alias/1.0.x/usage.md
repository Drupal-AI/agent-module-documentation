<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Unique Path Alias adds a `domain_id` property to core's `path_alias` entity, so the same alias (e.g. `/about-us`) can exist independently on each domain of a Domain-module site instead of colliding under core's global-uniqueness rule.

---

Core treats path aliases as globally unique: one `/about-us`, one target. On a single site that is correct. On a Domain-access site running several brands from one install it is the wrong constraint — each brand wants its own `/about-us`, pointing at its own node, and core's uniqueness check refuses the second one.

The module changes the constraint rather than working around it. A `hook_entity_base_field_info()` implementation adds a `domain_id` base field to the `path_alias` entity. `path_alias_presave` and `node_update` hooks stamp each node alias with the domain resolved from the node's `field_domain_source` (falling back to `field_domain_access`). `DomainUniquePathAliasConstraint`/`…Validator` extend core's `UniquePathAliasConstraint` so alias validation is scoped to that domain, and `DomainUniquePathAliasUniquifier` decorates Pathauto's uniquifier so generated aliases no longer get `-0`/`-1` suffixes just because another domain already uses the name. Inbound resolution is handled by decorating `path_alias.manager`: `DomainUniquePathAliasManager::getPathByAlias()` calls a domain-aware lookup so an alias owned by domain A returns null (i.e. 404, fail-closed) when requested on domain B.

Extending core's own constraint class rather than reimplementing it is the right call — it inherits core behaviour and changes only the scope of the lookup — but it does mean the module is coupled to core's implementation of that class, which is the thing to watch across core minor upgrades. The scope is deliberately narrow: only **nodes** are domain-resolved (taxonomy terms and other entity types are out of scope), and the module ships no routes, permissions, config page, or Drush commands.

Enabling the module backfills `domain_id` on existing aliases via `hook_install()`, and `hook_update_9001()` re-runs the same backfill in idempotent batches of 50 (reporting updated / neutral / unresolved counts). `hook_requirements()` warns at runtime if neither the `domain` (Domain 3.x) nor `url.site` (Domain 2.x) cache context is available, since without one the alias cache can bleed across domains.

---

- Serve the same `/contact` path on several domains, each resolving to a different node.
- Give each brand in a multi-domain install its own `/about-us`.
- Stop Pathauto appending `-0`/`-1` to an alias just because another domain already uses that name.
- Make path-alias uniqueness per-domain instead of global.
- Add a `domain_id` property to the core `path_alias` entity.
- Run multiple brands or affiliates from one Drupal install with independent URL structures.
- Return 404 for an alias when it is requested from a domain that does not own it (fail-closed).
- Keep core's normal alias validation behaviour within a single domain (duplicates still blocked).
- Pair with `domain_source` so each node's canonical domain drives its alias ownership.
- Fall back to `field_domain_access` when a node has no `field_domain_source` value.
- Generate per-domain aliases automatically through Pathauto patterns.
- Avoid manually prefixing aliases per brand to dodge collisions.
- Backfill `domain_id` on pre-existing aliases when first enabling the module (`hook_install`).
- Re-run the batched backfill safely with `drush updatedb` (`hook_update_9001`, idempotent).
- Keep aliases whose source is not a node (e.g. `/user/...`) global/neutral across domains.
- Migrate a multi-brand site onto Domain without losing shared path names.
- Re-test alias validation after a Drupal core minor upgrade (constraint extends a core class).
- Ensure the `domain` or `url.site` cache context is present so alias caches don't bleed across domains.
- Keep node aliases distinct per domain while sharing content types and templates.
- Resolve legacy aliases (empty `domain_id`) against their source node's domain.
- Support Drupal 10.2+ and 11 with Domain 2.x or 3.x and Pathauto 1.12+.
