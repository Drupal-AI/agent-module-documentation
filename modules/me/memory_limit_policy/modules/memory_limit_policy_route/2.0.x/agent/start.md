<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy Route — agent index

Provides the `route` policy condition (MemoryLimitConstraint plugin, class `Route`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_route -y`.

- **The `route` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/route.md](plugins/route.md)

Key facts:
- Plugin id: `route` (this submodule also registers `admin_route`).
- Stored in `policy_constraints` as `{ id: route, negate: bool, ... }` with a sequence of route names (one per line in the UI).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
