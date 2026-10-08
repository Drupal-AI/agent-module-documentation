<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Guard (field_guard) — agent index

**Fail-closed per-field access control** (`AccessResult::forbidden()` that nothing can override — not an `is_admin` role, not user 1). Version **1.3.x**. Core `^10.6 || ^11.3 || ^12`, PHP `>=8.1`. Package `Security`. Depends on core `field`, `user`. No admin UI, no routes, no Drush, no `.install`, no `hook_permission`.

Authoritative via `hook_entity_field_access()` (`field_guard.module`) — the one field verdict with no admin/permission bypass, applied wherever core calls field access (entity form, entity view, REST, JSON:API, Views). Config-driven map, defines **no permissions of its own**, ships empty (installing it changes nothing until configured).

- **Config map & mechanics** — the `field_guard.settings:protected` map, how the verdict is decided, the own-subject view exemption, cacheability, and the documented boundaries → [configure/settings.md](configure/settings.md).
- **Services / programmatic API** — `ProtectedFieldMap` (`requiredPermission`, `guardedFields`, `isProtected`, `viewExemptsOwnSubject`), `ExplicitPermissionChecker::hasExplicitPermission()`, `HostChainWalker::chain()` → [api/services.md](api/services.md).
- **Optional MCP submodule** — `field_guard_mcp` adds two read-only Tool API plugins (governed by MCP Sentinel) that report guarded fields and the guard's verdict → [../../modules/field_guard_mcp/1.3.x/agent/start.md](../../modules/field_guard_mcp/1.3.x/agent/start.md).

## At a glance

- **Map:** `field_guard.settings:protected.<entity_type>.<bundle>.<field_name>.<operation>` → permission. Operations are only `view`/`edit`; anything else is unprotected. An omitted operation and an empty-string permission are both treated as unset. Base fields (bundle NULL) are never matched.
- **Explicit-grant only:** access is decided by walking the account's roles, **skipping `is_admin` roles**, and asking each remaining role's own config — deliberately NOT `AccountInterface::hasPermission()` (which grants everything to admins/uid 1). Granting access is a reviewable line in a config diff.
- **Definition-level (NULL `$items`) fails closed:** the filter/sort question JSON:API's `FieldResolver::getFieldAccess()` and Views' `EntityField::access()` ask (no entity in scope) is answered `forbidden()`, so a guarded field is **unfilterable/unsortable for everyone**, permission holders included — this stops probing a never-rendered value via an exposed filter/sort.
- **Own-subject view exemption:** per-field opt-in `view_exempt_own_subject: true` stands the **view** guard down (returns neutral, so ordinary access decides) when the entity carrying the field roots at the acting user's own account. Host chain resolved by duck-typed `getParentEntity()` (`field_guard.host_chain_walker`), depth-capped (8), cycle-guarded, fail-closed; anonymous/orphan/unresolvable exempts nothing. No edit counterpart; the definition-level deny is untouched.

## New in 1.3.x

- **`field_guard.explicit_permission_checker` service** (`ExplicitPermissionChecker::hasExplicitPermission()`) — the explicit-permission rule extracted from the hook; the access hook, the MCP tools, and other callers share it. A post-update (`field_guard_post_update_register_explicit_permission_checker`) rebuilds the container so the service is registered before the hook needs it — run database updates after deploying.
- **`ProtectedFieldMap::guardedFields()`** — lists an entity type's guarded fields (names only), used by the MCP list tool and available to any caller.
- **`field_guard_mcp` submodule** — optional read-only MCP tools (see link above).

## Services

- `field_guard.field_map` → `Drupal\field_guard\ProtectedFieldMap` (a `CacheableDependencyInterface` carrying `config:field_guard.settings`).
- `field_guard.explicit_permission_checker` → `Drupal\field_guard\ExplicitPermissionChecker`.
- `field_guard.host_chain_walker` → `Drupal\field_guard\HostChainWalker`.
