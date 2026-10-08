<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy HTTP Header — agent index

Provides the `http_header` policy condition (MemoryLimitConstraint plugin, class `HttpHeader`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_http_header -y`.

- **The `http_header` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/http-header.md](plugins/http-header.md)

Key facts:
- Plugin id: `http_header`.
- Stored in `policy_constraints` as `{ id: http_header, negate: bool, ... }` with header_name (string), header_value (string) and match_mode (exact|contains|starts_with|ends_with|regex).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
