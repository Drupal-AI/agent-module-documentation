<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy Query Param — agent index

Provides the `query_param` policy condition (MemoryLimitConstraint plugin, class `QueryParam`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_query_param -y`.

- **The `query_param` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/query-param.md](plugins/query-param.md)

Key facts:
- Plugin id: `query_param`.
- Stored in `policy_constraints` as `{ id: query_param, negate: bool, ... }` with a newline-separated string of query parameter KEYS (one per line).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
