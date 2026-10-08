<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy HTTP Method — agent index

Provides the `http_method` policy condition (MemoryLimitConstraint plugin, class `HttpMethod`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_http_method -y`.

- **The `http_method` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/http-method.md](plugins/http-method.md)

Key facts:
- Plugin id: `http_method`.
- Stored in `policy_constraints` as `{ id: http_method, negate: bool, ... }` with a sequence of lowercase HTTP method names (get, head, post, put, delete, connect, options, trace, patch).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
