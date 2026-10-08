<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Unique Path Alias (domain_unique_path_alias) — agent index

Makes path-alias uniqueness **per-domain instead of global** for [Domain](https://www.drupal.org/project/domain)-module
sites. Adds a `domain_id` base field to core's `path_alias` entity so the same alias (e.g. `/contact`)
can exist once per domain and resolve to different content on each. Version **1.0.1-beta6**.
Package `Domain`. Core `^10.2 || ^11`. License GPL-2.0-or-later.

- Dependencies (all required): `domain`, `domain_source`, `pathauto`, plus core `path_alias`,
  `field`, `node`. Composer: `drupal/domain:^2.0 || ^3.0`, `drupal/pathauto:^1.12`.
- **No routes, no permissions, no config page, no config schema, no Drush.** Scope is **nodes only**.

**Full mechanism (services, decorators, lookup, uniquifier, constraint, hooks, install/backfill,
cache context) →** [api/domain-aware-alias.md](api/domain-aware-alias.md)

## What it provides (from source)

- **`domain_id` base field** on `path_alias` — `entity_base_field_info` in
  `src/Hook/DomainUniquePathAliasHooks.php`.
- **Alias-manager decorator** `DomainUniquePathAliasManager` (decorates `path_alias.manager`):
  domain-aware inbound resolution; cross-domain aliases stay unresolved (fail-closed → 404).
- **Lookup** `DomainUniquePathAliasLookup` (service `…lookup`): explicit-domain match first, then
  legacy (`domain_id = ''`) resolved against the source node's domain.
- **Pathauto uniquifier decorator** `DomainUniquePathAliasUniquifier` (decorates
  `pathauto.alias_uniquifier`): collision check scoped to the domain, so no needless `-0`/`-1`.
- **Validation constraint** `DomainUniquePathAliasConstraint` + `…Validator` — extend core's
  `UniquePathAliasConstraint`; `validation_constraint_alter` swaps the class behind the
  `UniquePathAlias` constraint id.
- **Helper** `DomainUniquePathAliasHelper` (service `…helper`): resolves a node's domain from
  `field_domain_source` → `field_domain_access`, and the active domain from the request.
- **Hooks**: `path_alias_presave` + `node_update` stamp/sync `domain_id`; `hook_install` +
  `hook_update_9001` backfill it; `hook_requirements` warns when no `domain`/`url.site` cache context.

**Upgrade watch point:** the constraint and its validator extend core classes directly, so they are
coupled to core's implementation — re-test alias validation after each core minor upgrade.

Narrow scope: this is a fix for the Domain/core-alias uniqueness incompatibility (nodes only), not a
general-purpose alias module.
