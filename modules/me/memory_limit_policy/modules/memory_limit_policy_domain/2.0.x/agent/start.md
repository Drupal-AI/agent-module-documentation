<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy Domain — agent index

Provides the `domain` policy condition (MemoryLimitConstraint plugin, class `Domain`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_domain -y`.

- **The `domain` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/domain.md](plugins/domain.md)

Key facts:
- Plugin id: `domain`.
- Stored in `policy_constraints` as `{ id: domain, negate: bool, ... }` with a sequence of host names or regex patterns (one per line, no delimiters).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
