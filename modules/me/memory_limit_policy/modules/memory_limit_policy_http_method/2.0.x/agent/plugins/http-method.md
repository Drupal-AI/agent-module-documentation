<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `http_method` condition plugin

Class `Drupal\memory_limit_policy_http_method\Plugin\MemoryLimitConstraint\HttpMethod`, annotated `@MemoryLimitConstraint(id = "http_method", title = @Translation("HTTP method"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **methods** — a sequence of lowercase HTTP method names (get, head, post, put, delete, connect, options, trace, patch).
- Always also carries `id: http_method` and `negate` (bool).
- Schema: Declared under memory_limit_policy.constraint.plugin.role in the submodule schema (a copy-paste artifact), but the real stored key is 'methods' (sequence).
- The UI presents checkboxes for the nine standard methods; values are stored lowercased.

## Matching

TRUE when the current request method (lowercased) is in the configured list.

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: http_method
    negate: false
    methods:
      - post
      - put
```

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
