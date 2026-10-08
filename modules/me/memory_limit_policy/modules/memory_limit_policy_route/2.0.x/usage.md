<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy Route adds a `route` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on the route.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `route`, class `Route`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: route` plus a sequence of route names (one per line in the UI). The plugin's `evaluate()` decides whether the constraint matches the current request: TRUE when the current route name is in the configured list. This submodule also registers a second plugin 'admin_route' (class AdminRoute) that matches any admin route via router.admin_context. Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.route -> routes (sequence); memory_limit_policy.constraint.plugin.admin_route -> (negate only). The route form validates each entered route exists (route_provider->getRouteByName), raising a form error for unknown routes.

---

- Raise memory for a specific route like `system.batch_page`.
- Apply a blanket higher limit to ALL admin routes with the `admin_route` plugin.
- Target `views.ajax` or a heavy view route by name.
- Scope memory to `entity.node.edit_form` across all bundles.
- List several route names (one per line) in a single constraint.
- Negate to exclude a route from a broad policy.
- Combine an admin_route constraint with a Role constraint.
- Bump memory for a REST resource route serializing large data.
- Use route matching instead of paths for stability across alias changes.
- Rely on form validation to catch typo'd route names before saving.
- Keep public canonical routes on the default limit.
- Give the batch API route more memory during long operations.
- Target the migrate UI route during a data migration.
- Export the route policy as config for deployment.
- Apply more memory only to `system.admin` and its children via admin_route.
- Diagnose OOM on a single controller by scoping to its route name.
