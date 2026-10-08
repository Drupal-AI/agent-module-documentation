<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy Role adds a `role` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on the user role.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `role`, class `Role`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: role` plus a map of selected role machine names ({role: role}). The plugin's `evaluate()` decides whether the constraint matches the current request: TRUE when the current user has any of the selected roles (array_intersect of configured roles and current_user->getRoles()). Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.role -> roles (sequence of role ids). It also adds a config dependency on each selected role (user.role.<id>).

---

- Raise memory for editors by matching the `content_editor` role.
- Give administrators a higher limit than anonymous visitors.
- Apply extra memory to any authenticated user with the `authenticated` role.
- Combine with a Path constraint so only editors on `/admin/*` get more memory.
- Negate the constraint to mean 'every role except this one'.
- Target a custom role such as `report_viewer` for a heavy dashboard.
- Avoid over-provisioning PHP-FPM by scoping memory to privileged roles only.
- Stack several roles in one constraint (matches if the user has ANY of them).
- Keep anonymous traffic on the default memory_limit while staff get more.
- Use with the HTTP method constraint to bump memory for editors doing POSTs.
- Export the role policy as config and deploy across environments.
- Diagnose OOM on an editor-only interface by scoping a temporary policy to that role.
- Pair with weight ordering so a role policy overrides a broader path policy.
- Grant more memory to a migration/admin role during a data import window.
- Scope a high limit to a `developer` role on staging only.
- Ensure the constraint tracks its roles as config dependencies for safe staging.
