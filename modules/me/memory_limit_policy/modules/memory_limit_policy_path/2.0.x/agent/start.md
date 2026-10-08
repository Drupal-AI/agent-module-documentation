<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy Path — agent index

Provides the `path` policy condition (MemoryLimitConstraint plugin, class `Path`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_path -y`.

- **The `path` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/path.md](plugins/path.md)

Key facts:
- Plugin id: `path`.
- Stored in `policy_constraints` as `{ id: path, negate: bool, ... }` with a newline-separated string of paths (one per line), '*' as wildcard.
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
