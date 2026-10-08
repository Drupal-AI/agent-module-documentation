<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy Path adds a `path` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on the path.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `path`, class `Path`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: path` plus a newline-separated string of paths (one per line), '*' as wildcard. The plugin's `evaluate()` decides whether the constraint matches the current request: TRUE when the current path (or its alias) matches any configured pattern via the path.matcher service (Drupal's standard path matching, so '/node/*/edit' style wildcards work). Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.path -> paths (text). It checks both the internal path and the resolved alias. A hook_update (8001) prefixes stored paths with a leading slash.

---

- Raise memory only on `/admin/reports/*` where aggregation is heavy.
- Target a single slow page like `/admin/content` with more memory.
- Use a wildcard `/node/*/edit` to cover all node edit forms.
- Match by URL alias as well as internal path (both are checked).
- Scope a high limit to a custom report route path such as `/dashboard/*`.
- Negate to apply memory 'everywhere except' a set of lightweight paths.
- Combine with a Role constraint so only editors on `/admin/*` get more.
- List several paths (one per line) in a single constraint.
- Keep the front page and public pages on the default limit.
- Bump memory for a heavy migration UI path during rollout.
- Diagnose OOM on one interface by scoping a policy to its path.
- Export the path policy as config for deployment.
- Match a views page path that renders many entities.
- Use `/*` to broadly match then override with a higher-weight narrower policy.
- Target a REST/JSON endpoint path that serializes large payloads.
- Scope more memory to a bulk-edit path without touching the whole site.
