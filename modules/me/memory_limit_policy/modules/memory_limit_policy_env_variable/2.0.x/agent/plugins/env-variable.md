<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `env_variable` condition plugin

Class `Drupal\memory_limit_policy_env_variable\Plugin\MemoryLimitConstraint\EnvVariable`, annotated `@MemoryLimitConstraint(id = "env_variable", title = @Translation("Environment variable"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **name / values** — name (the environment variable to read) and values (a sequence of exact strings or regex patterns; empty matches any value).
- Always also carries `id: env_variable` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.env_variable -> name (text), values (sequence).
- Matching uses the PHP superglobal $_ENV, so the variable must be exported into the PHP environment.

## Matching

Reads $_ENV[name]; returns FALSE if unset; TRUE if values is empty (variable just needs to exist); otherwise TRUE when the value equals one of the configured values or matches one as a case-insensitive regex.

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: env_variable
    negate: false
    name: APP_ENV
    values:
      - migration
```

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
