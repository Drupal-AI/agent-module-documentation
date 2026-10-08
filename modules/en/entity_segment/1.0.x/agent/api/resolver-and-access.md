<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Resolver, audience access, permissions & access handlers

## Resolver — `SegmentResolver` (`entity_segment.resolver`)

`SegmentResolverInterface` with two methods:
- `resolve($segment)` — the raw, **non-access-filtered** audience: an array of deduplicated ascending int IDs of the segment's target type. Live on every call; no cache, no materialized table, no cron.
- `resolveAccessible($segment, $account)` — loads the raw audience, keeps only IDs the account may `view` (in resolve order). O(audience), uncached by design.

Algorithm (`analyze()` + `resolveGroup()`): each condition node is instantiated once, given the target type, and marked queryable if its plugin implements `QueryableSegmentPluginInterface`. A group whose children are **wholly** queryable folds into a single nested entity query (`executeQuery()` / `buildConditionGroup()`, `accessCheck(FALSE)`); set-based children are resolved via `resolveToIds()` and combined in PHP (intersect under AND, merge under OR). Conjunction-aware short-circuit: under AND an empty set empties the group; never under OR. An empty group selects **no** entities at any depth.

## Audience access chokepoint — `AudienceAccess` (`entity_segment.audience_access`)

The single place membership is exposed; every consumer (Views, tokens, JSON:API, VBO, ECA) routes through it, never the resolver directly.
- `filtered($segment, $account)` → `resolveAccessible()`; always safe to show that account.
- `raw($segment, $account)` → the full audience **only** if `rawAllowed()`, else `[]` (deny returns empty, not an exception).
- `rawAllowed($segment, $account)` → `$account->hasPermission("view resolved {$segment->bundle()} segment membership")`.

## Permissions — `SegmentPermissions` + `entity_segment.permissions.yml`

Static, `restrict access: TRUE`:
- `administer segment types` — governs the type registry only.
- `administer segments` — segment content super-permission; bypasses per-type/scope rules in both access paths.

Dynamic per segment type (`permission_callbacks` → `SegmentPermissions::permissions`), each with a config dependency on its type so deletion cleans up grants. Ten per type (`buildPermissions()`): `administer $id segments` (restrict), `create $id segment`, `create global $id segment`, `view own $id segment`, `view any global $id segment`, `update/delete own $id segment`, `update/delete any global $id segment`, and `view resolved $id segment membership` (restrict — the raw-audience gate).

## Per-entity access — `SegmentAccessControlHandler`

Decides `view`/`update`/`delete` (results `cachePerUser` + entity dependency). Order: `administer segments` → `administer $bundle segments` → owner + `$op own $bundle segment` → **scope gate** (a `personal` segment is never reachable via an "any" permission) → global falls to `$op any global $bundle segment`. Create access is per bundle: `administer segments` OR `administer $bundle segments` OR `create $bundle segment`.

## Query access — `SegmentQueryAccessHandler`

Mirrors the handler as base-field conditions so `accessCheck(TRUE)` queries (list builder, Views, JSON:API) return only permitted rows. `administer segments` = no restriction; per bundle it ORs `administer $bundle segments` (whole bundle), `$op own` (bundle + owner), `$op any global` (bundle + scope=global); no grant anywhere = always-false. Deliberately does **not** grant a bypass on `administer segment types`. Keeps the `entity.query_access.segment` event for other modules to refine.

## List route access — `SegmentListAccessCheck` (`entity_segment.segment_list_access`)

Backs the `_segment_list_access: 'TRUE'` requirement on the segment listing routes (all-types collection, per-type collection, and the People/CRM areas which pin a `segment_type` default). A deliberate superset of query access: opens the page for any per-type view grant or the two site-wide admin permissions (so a registry-only admin reaches an empty listing rather than a 403); rows are still filtered by query access. Cacheable per permissions; never returns forbidden.
