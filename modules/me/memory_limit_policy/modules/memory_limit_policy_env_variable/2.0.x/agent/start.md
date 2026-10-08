<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy Environment Variable — agent index

Provides the `env_variable` policy condition (MemoryLimitConstraint plugin, class `EnvVariable`) for the parent **Memory Limit Policy** module. No config UI of its own — the constraint is configured inside a `memory_limit_policy` entity. Enable with `drush en memory_limit_policy_env_variable -y`.

- **The `env_variable` condition: config keys, matching logic, how to add it to a policy** →
  [plugins/env-variable.md](plugins/env-variable.md)

Key facts:
- Plugin id: `env_variable`.
- Stored in `policy_constraints` as `{ id: env_variable, negate: bool, ... }` with name (the environment variable to read) and values (a sequence of exact strings or regex patterns; empty matches any value).
- Parent mechanics (evaluation, weight, subscriber): see the parent module's `agent/api/evaluation.md`.
