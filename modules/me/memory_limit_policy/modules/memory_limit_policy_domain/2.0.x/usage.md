<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy Domain adds a `domain` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on the domain.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `domain`, class `Domain`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: domain` plus a sequence of host names or regex patterns (one per line, no delimiters). The plugin's `evaluate()` decides whether the constraint matches the current request: TRUE when the request host equals a configured domain (plain match) or matches one as a case-insensitive regex ({pattern}i). Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.domain -> domains (sequence). This is a plain host/regex match on request->getHost(); it does NOT depend on the Domain Access module. Patterns are entered without delimiters, like Trusted Host settings.

---

- Give a heavy subdomain like `reports.example.com` more memory.
- Apply different limits per host in a multisite/multi-domain setup.
- Match a group of hosts with a regex pattern (no delimiters).
- Scope more memory to a staging domain only.
- List several exact hosts (one per line) in one constraint.
- Negate to apply memory on every host except one.
- Combine with a Path constraint to target a path on one domain.
- Match all `*.example.com` subdomains via a regex.
- Keep the marketing domain on the default limit while an app domain gets more.
- Bump memory for an API domain that serializes large payloads.
- Export the domain policy as config for deployment.
- Diagnose OOM occurring only on one hostname.
- Use plain host matching without needing the Domain module.
- Scope memory to a country/locale-specific domain.
- Apply more memory to an internal admin hostname.
- Use with weight so the domain policy overrides a broad default.
