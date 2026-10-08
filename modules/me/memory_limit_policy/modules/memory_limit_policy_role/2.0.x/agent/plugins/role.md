<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `role` condition plugin

Class `Drupal\memory_limit_policy_role\Plugin\MemoryLimitConstraint\Role`, annotated `@MemoryLimitConstraint(id = "role", title = @Translation("Role"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **roles** — a map of selected role machine names ({role: role}).
- Always also carries `id: role` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.role -> roles (sequence of role ids).
- It also adds a config dependency on each selected role (user.role.<id>).

## Matching

TRUE when the current user has any of the selected roles (array_intersect of configured roles and current_user->getRoles()).

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: role
    negate: false
    roles:
      content_editor: content_editor
```

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
