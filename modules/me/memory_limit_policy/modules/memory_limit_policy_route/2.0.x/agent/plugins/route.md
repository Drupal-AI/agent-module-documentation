<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `route` condition plugin

Class `Drupal\memory_limit_policy_route\Plugin\MemoryLimitConstraint\Route`, annotated `@MemoryLimitConstraint(id = "route", title = @Translation("Route"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **routes** — a sequence of route names (one per line in the UI).
- Always also carries `id: route` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.route -> routes (sequence); memory_limit_policy.constraint.plugin.admin_route -> (negate only).
- The route form validates each entered route exists (route_provider->getRouteByName), raising a form error for unknown routes.

## Matching

TRUE when the current route name is in the configured list. This submodule also registers a second plugin 'admin_route' (class AdminRoute) that matches any admin route via router.admin_context.

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: route
    negate: false
    routes:
      - system.batch_page
```

## The `admin_route` plugin

This submodule also registers a second plugin, id `admin_route` (class `AdminRoute`), with no configuration beyond `negate`. Its `evaluate()` returns `router.admin_context->isAdminRoute()`, so it matches every admin route. Use it to apply a memory limit to the whole admin area without listing routes. Schema: `memory_limit_policy.constraint.plugin.admin_route`.

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
