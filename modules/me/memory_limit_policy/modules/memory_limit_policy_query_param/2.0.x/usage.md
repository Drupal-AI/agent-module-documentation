<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy Query Param adds a `query_param` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on the query param.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `query_param`, class `QueryParam`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: query_param` plus a newline-separated string of query parameter KEYS (one per line). The plugin's `evaluate()` decides whether the constraint matches the current request: TRUE when any configured parameter KEY is present in the request query string (array_intersect of request query keys and configured keys). It matches on the presence of the key, not its value. Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.query_param -> query_param (text). Only the parameter name is matched; the value is not compared.

---

- Raise memory when `?export=1` is present on a listing page.
- Bump memory for `?debug` requests that render extra diagnostics.
- Scope more memory to `?format=csv` heavy downloads.
- Match a `?full=1` parameter that expands an expensive view.
- List several parameter keys (one per line) in one constraint.
- Negate to apply memory when a parameter is absent.
- Combine with a Path constraint to target `/reports?export`.
- Match only on the key, ignoring the value, for simple toggles.
- Keep normal page views (no special param) on the default limit.
- Give a `?print` view more memory for large rendering.
- Export the query-param policy as config for deployment.
- Diagnose OOM that only occurs with a specific query flag.
- Target an AJAX endpoint that uses a `?_wrapper_format` param.
- Scope memory to a `?batch` operation parameter.
- Use with weight so the param policy overrides a broader one.
- Enable a debug/export flow to run with extra headroom.
