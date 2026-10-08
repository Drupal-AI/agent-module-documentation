<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `query_param` condition plugin

Class `Drupal\memory_limit_policy_query_param\Plugin\MemoryLimitConstraint\QueryParam`, annotated `@MemoryLimitConstraint(id = "query_param", title = @Translation("Query param"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **query_param** — a newline-separated string of query parameter KEYS (one per line).
- Always also carries `id: query_param` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.query_param -> query_param (text).
- Only the parameter name is matched; the value is not compared.

## Matching

TRUE when any configured parameter KEY is present in the request query string (array_intersect of request query keys and configured keys). It matches on the presence of the key, not its value.

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: query_param
    negate: false
    query_param: "export"
```

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
