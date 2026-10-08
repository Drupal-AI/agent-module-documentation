<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `path` condition plugin

Class `Drupal\memory_limit_policy_path\Plugin\MemoryLimitConstraint\Path`, annotated `@MemoryLimitConstraint(id = "path", title = @Translation("Path"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **paths** — a newline-separated string of paths (one per line), '*' as wildcard.
- Always also carries `id: path` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.path -> paths (text).
- It checks both the internal path and the resolved alias. A hook_update (8001) prefixes stored paths with a leading slash.

## Matching

TRUE when the current path (or its alias) matches any configured pattern via the path.matcher service (Drupal's standard path matching, so '/node/*/edit' style wildcards work).

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: path
    negate: false
    paths: "/admin/reports/*"
```

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
