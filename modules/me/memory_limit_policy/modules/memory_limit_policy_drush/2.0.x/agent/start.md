<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy Drush — agent index

Provides the `drush` policy condition (MemoryLimitConstraint plugin, class `Drush`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_drush -y`.

- **The `drush` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/drush.md](plugins/drush.md)

Key facts:
- Plugin id: `drush`.
- Stored in `policy_constraints` as `{ id: drush, negate: bool, ... }` with a newline-separated string of Drush command names (one per line).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
