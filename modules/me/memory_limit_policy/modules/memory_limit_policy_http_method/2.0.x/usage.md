<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy HTTP Method adds a `http_method` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on the HTTP method.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `http_method`, class `HttpMethod`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: http_method` plus a sequence of lowercase HTTP method names (get, head, post, put, delete, connect, options, trace, patch). The plugin's `evaluate()` decides whether the constraint matches the current request: TRUE when the current request method (lowercased) is in the configured list. Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: Declared under memory_limit_policy.constraint.plugin.role in the submodule schema (a copy-paste artifact), but the real stored key is 'methods' (sequence). The UI presents checkboxes for the nine standard methods; values are stored lowercased.

---

- Raise memory only for write requests (`POST`, `PUT`, `PATCH`).
- Bump memory for API `PUT`/`PATCH` calls that deserialize large bodies.
- Keep `GET`/`HEAD` reads on the default limit.
- Scope more memory to `DELETE` bulk operations.
- Combine with a Path constraint to target POSTs on one endpoint.
- Negate to apply 'all methods except GET'.
- Select multiple methods in one constraint (matches ANY of them).
- Give form submissions (POST) more memory than page views.
- Target `OPTIONS` preflight handling if it is unexpectedly heavy.
- Pair with a Role constraint so only editors' POSTs get more memory.
- Export the method policy as config for deployment.
- Diagnose OOM that only happens on writes, not reads.
- Scope memory for a webhook receiver that only accepts POST.
- Apply more memory to `PATCH` on a JSON:API resource.
- Keep anonymous GET traffic cheap while POSTs get headroom.
- Use with weight so a method policy overrides a broad default.
