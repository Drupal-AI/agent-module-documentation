<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy — agent index

Overrides PHP `memory_limit` per request via `memory_limit_policy` **config entities**. Each
policy = a `memory` value + ordered `policy_constraints` (plugin instances). A request-time
event subscriber applies a policy's memory with `ini_set()` when **all** its constraints pass.
The base module ships **no** constraint plugins — conditions come from the submodules. UI at
`/admin/config/performance/memory-limit-policy/list`; permission `administer memory limit policies`.

- **Create / edit / export policies, memory value, weight, status, settings** →
  [configure/policies.md](configure/policies.md)
- **The `MemoryLimitConstraint` plugin type (write your own condition)** →
  [plugins/memory-limit-constraint.md](plugins/memory-limit-constraint.md)
- **How evaluation works (subscriber, weight order, AND + negate, override headers)** →
  [api/evaluation.md](api/evaluation.md)

Key facts:
- Config entity: `memory_limit_policy.memory_limit_policy.<id>`; exported keys: `id`, `label`,
  `status`, `weight`, `memory` (string, e.g. `256M`), `langcode`, `policy_constraints`.
- `policy_constraints` is a sequence of maps, each `{ id: <plugin_id>, negate: bool, ... }`.
- Constraint plugin type dir `Plugin/MemoryLimitConstraint`, annotation `@MemoryLimitConstraint`,
  manager `plugin.manager.memory_limit_policy.memory_limit_constraint`, alter hook
  `memory_limit_policy_constraint_info`.
- Condition plugin ids by submodule: `role`, `path`, `route` + `admin_route`, `http_method`,
  `http_header`, `query_param`, `domain`, `env_variable`, `drush`.
