<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy Role — agent index

Provides the `role` policy condition (MemoryLimitConstraint plugin, class `Role`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_role -y`.

- **The `role` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/role.md](plugins/role.md)

Key facts:
- Plugin id: `role`.
- Stored in `policy_constraints` as `{ id: role, negate: bool, ... }` with a map of selected role machine names ({role: role}).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
