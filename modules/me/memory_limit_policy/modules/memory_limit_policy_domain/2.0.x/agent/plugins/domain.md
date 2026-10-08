<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `domain` condition plugin

Class `Drupal\memory_limit_policy_domain\Plugin\MemoryLimitConstraint\Domain`, annotated `@MemoryLimitConstraint(id = "domain", title = @Translation("Domain"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **domains** — a sequence of host names or regex patterns (one per line, no delimiters).
- Always also carries `id: domain` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.domain -> domains (sequence).
- This is a plain host/regex match on request->getHost(); it does NOT depend on the Domain Access module. Patterns are entered without delimiters, like Trusted Host settings.

## Matching

TRUE when the request host equals a configured domain (plain match) or matches one as a case-insensitive regex ({pattern}i).

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: domain
    negate: false
    domains:
      - reports.example.com
```

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
