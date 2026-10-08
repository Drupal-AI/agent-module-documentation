<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Guard — agent index

**Fail-closed per-field access control** (`AccessResult::forbidden()` nothing can override — not an `is_admin` role, not user 1). Version **1.2.0**. Core `^10.6 || ^11.3 || ^12`, PHP `>=8.1`.

Authoritative via `hook_entity_field_access()` — the one field verdict with no admin/permission bypass, applied wherever core calls field access (entity form, entity view, REST, JSON:API, Views). Config-driven map, defines **no permissions of its own**, ships empty. Depends on core `field`, `user`. Strong security-positive design.

- **Config map:** `field_guard.settings:protected.<entity_type>.<bundle>.<field_name>.<operation>` → permission. Operations are only `view`/`edit`; anything else is unprotected. An omitted operation and an empty-string permission are both treated as unset (fail open only for the *unlisted* field — never a silent total lock). See [configuration.md](configuration.md).
- **Explicit-grant only:** access is decided by walking the account's roles, **skipping `is_admin` roles**, and asking each remaining role's own config — deliberately NOT `AccountInterface::hasPermission()` (which grants everything to admins/uid 1). Granting access is a reviewable line in a config diff.
- **Definition-level (NULL `$items`) fails closed:** the filter/sort question JSON:API's `FieldResolver::getFieldAccess()` and Views' `EntityField::access()` ask (no entity in scope) is answered `forbidden()`, so a guarded field is **unfilterable/unsortable for everyone**, permission holders included — this stops probing a never-rendered value via an exposed filter/sort.
- **New in 1.2.0 — own-subject view exemption:** per-field opt-in `view_exempt_own_subject: true` stands the **view** guard down (returns neutral, so ordinary access decides) when the entity carrying the field roots at the acting user's own account. Host chain resolved by duck-typed `getParentEntity()` (`field_guard.host_chain_walker`), depth-capped (8), cycle-guarded, fail-closed; anonymous/orphan/unresolvable exempts nothing. No edit counterpart; the definition-level deny is untouched.

Services: `field_guard.field_map` (`ProtectedFieldMap`, a `CacheableDependencyInterface` carrying `config:field_guard.settings`), `field_guard.host_chain_walker` (`HostChainWalker`). No admin UI, no routes, no Drush, no `.install`, no `hook_permission`.

See [configuration.md](configuration.md) for the map format, own-subject exemption, and boundaries (programmatic reads, unguarded-field Views handlers, direct SQL, no audit log).
