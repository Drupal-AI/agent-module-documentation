<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-domain path aliases — full mechanism

How `domain_unique_path_alias` makes aliases unique per Domain-module domain. All class paths are
under `src/`. There are no routes, permissions, config objects, config schema, or Drush commands.

## Install & enable

```bash
composer require 'drupal/domain_unique_path_alias:^1.0@beta'
drush en domain_unique_path_alias -y
```

Requires (info.yml `dependencies`): `domain`, `domain_source`, `pathauto`, core `path_alias`,
`field`, `node`. Composer `require`: `drupal/domain:^2.0 || ^3.0`, `drupal/pathauto:^1.12`. Core
`^10.2 || ^11`.

On enable, `domain_unique_path_alias_install()` (`.install`) loads every `path_alias` that lacks a
`domain_id` and sets it from `DomainUniquePathAliasHelper::getPathDomainId($path)`.

## The `domain_id` base field

`DomainUniquePathAliasHooks::entityBaseFieldInfo()` (`#[Hook('entity_base_field_info')]`) adds a
`string` base field **`domain_id`** to the `path_alias` entity (label "Domain Id"). This is the only
schema change; enabling the module runs the entity-update that creates the column.

## Stamping `domain_id` (write path)

`src/Hook/DomainUniquePathAliasHooks.php`:

- **`pathAliasPresave()`** (`#[Hook('path_alias_presave')]`): splits the alias's `path`; if it is
  `/node/{nid}`, loads the node and sets `domain_id` to
  `helper->getDomainIdFromEntity($node) ?? ''`. Non-node aliases are left untouched (neutral).
- **`nodeUpdate()`** (`#[Hook('node_update')]`): when a node's resolved domain changes, `syncNodeAliases()`
  re-stamps every `path_alias` whose `path` is `/node/{nid}` to the new `domain_id`.

`DomainUniquePathAliasHelper::getDomainIdFromEntity()` reads `field_domain_source` first, else the
first `field_domain_access` value, else `null`. `getPathDomainId(string $path)` maps a `/node/{nid}`
path to that node's domain (returns `null` for non-node or missing nodes — the module is **nodes
only**).

## Validation: per-domain uniqueness (create/edit path)

`DomainUniquePathAliasHooks::validationConstraintAlter()` (`#[Hook('validation_constraint_alter')]`)
rebinds the core `UniquePathAlias` constraint id to
`DomainUniquePathAliasConstraint` (which extends core's `UniquePathAliasConstraint` and only adds
`messageDomain = 'The alias %alias is already in use in this domain (%domain).'`).

`DomainUniquePathAliasConstraintValidator` (extends core's `UniquePathAliasConstraintValidator`) runs
an entity query on `path_alias` matching `alias` + `langcode` (excluding the current entity and its
own path). It reads the target domain from `helper->getDomainIdByRequest()`; when non-empty it adds a
`domain_id = <that domain>` condition, so a duplicate alias on a **different** domain is allowed while
a duplicate **within** the same domain raises `messageDomain`. Falls back to core's message /
different-capitalization message otherwise. Violation placeholders (`%alias`, `%domain`) go through
`buildViolation()` and are auto-escaped.

## Pathauto uniquifier decorator (generation path)

`DomainUniquePathAliasUniquifier` (service `domain_unique_path_alias.alias_uniquifier`, `decorates:
pathauto.alias_uniquifier`) implements `AliasUniquifierInterface`:

- `isReserved($alias, $source, $langcode, $domain_id = NULL)`: resolves `$domain_id` from the source
  node when not given. If it is `null`/`''` (unknown/neutral), delegates to the **inner** Pathauto
  uniquifier (global check). Otherwise runs a `path_alias` query scoped to that `domain_id`
  (langcode priority: exact → `und`); a match for a different source means reserved. Then checks
  core routes (`inner->isRoute()` when available) and the `hook_pathauto_is_alias_reserved` hooks via
  a short-circuiting `invokeAllWith`.
- `uniquify(&$alias, …)`: unchanged Pathauto algorithm (truncate + `separator . $i` suffix loop) but
  driven by the domain-scoped `isReserved()`, so an alias already used on **another** domain does not
  force a suffix.

## Inbound resolution (read path)

`DomainUniquePathAliasManager` (service `domain_unique_path_alias.path_alias_manager`, `decorates:
path_alias.manager`) implements `AliasManagerInterface`:

- `getPathByAlias($alias, $langcode)`: returns asset-looking paths (`svg|png|jpe?g|css|js|gif|webp|ts`)
  unchanged; resolves langcode and the active `domain_id` via `helper->getDomainIdByRequest()`. With
  no domain context it defers to the inner core manager. Otherwise it calls
  `DomainUniquePathAliasLookup::lookup()` and returns the alias unchanged (→ 404, fail-closed) when
  the lookup yields nothing — so a cross-domain alias never resolves.
- `getAliasByPath()`, `cacheClear()`, `setCacheKey()`, `writeCache()` delegate to the inner manager.

`DomainUniquePathAliasLookup` (service `domain_unique_path_alias.lookup`, ctor: `@database`,
`@…helper`):

- `lookupByDomain()`: `path_alias` row where `alias` + `status = 1` + `langcode` (exact → `und`) +
  `domain_id = <current>`. Explicit ownership wins.
- `lookupLegacy()`: rows with `domain_id = ''`; a candidate is accepted only if its source node is
  **not domainisable** (`getPathDomainId` → null, neutral) or its source domain equals the current
  domain — legacy/cross-domain rows are otherwise refused (fail-closed).

All DB access uses the query builder's `->condition()` bindings (no string-concatenated SQL).

## Backfilling existing data

`domain_unique_path_alias_update_9001()` (`.install`) re-runs the install backfill idempotently in
batches of 50: for each `/node/{nid}` alias with an empty `domain_id` it sets the node's resolved
domain, counting `updated` / `neutral` (non-node or no domain) / `unresolved` (missing node), and
reports the totals as a status message. Run with `drush updatedb -y`.

## Cache context requirement

`domain_unique_path_alias_requirements('runtime')` checks the cache-contexts manager: Domain 3.x
ships a `domain` context (nothing to warn). Otherwise it needs `url.site` (Domain 2.x); if neither
exists it emits `REQUIREMENT_WARNING` — without a per-domain context the alias cache can bleed across
domains. `hook_uninstall()` runs a Field API purge batch and clears cached entity-type definitions.
