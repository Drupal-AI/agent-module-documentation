<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy HTTP Header adds a `http_header` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on HTTP headers.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `http_header`, class `HttpHeader`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: http_header` plus header_name (string), header_value (string) and match_mode (exact|contains|starts_with|ends_with|regex). The plugin's `evaluate()` decides whether the constraint matches the current request: Reads the named request header and compares it to header_value using match_mode; returns FALSE (falls back to negate) when the header is absent. Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.http_header -> header_name, header_value, match_mode (all strings). Header name matching is case-insensitive; regex mode validates the pattern on submit and expects delimiters (e.g. /mobile-.*/i). Default match_mode is 'exact'.

---

- Raise memory when a request carries `X-Consumer: importer`.
- Match an `Accept` header containing `application/vnd.api+json`.
- Use `starts_with` to match any `X-Client-mobile-*` value.
- Use `regex` mode for complex header value matching (e.g. `/mobile-.*/i`).
- Scope memory to requests from a specific API gateway header.
- Match a custom `X-Request-Type: export` header for heavy exports.
- Negate to apply memory when a header is NOT the given value.
- Combine with a Path constraint to target one endpoint + header.
- Give internal service-to-service calls (identified by header) more memory.
- Use `ends_with` to match header values with a common suffix.
- Keep normal browser traffic (no special header) on the default limit.
- Export the header policy as config for deployment.
- Diagnose OOM traced to a particular client via its header.
- Match a load-balancer or CDN header to scope memory.
- Rely on case-insensitive header-name matching (X-Consumer == x-consumer).
- Validate regex patterns at save time to avoid runtime errors.
