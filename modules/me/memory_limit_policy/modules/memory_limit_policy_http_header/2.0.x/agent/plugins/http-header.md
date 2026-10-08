<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `http_header` condition plugin

Class `Drupal\memory_limit_policy_http_header\Plugin\MemoryLimitConstraint\HttpHeader`, annotated `@MemoryLimitConstraint(id = "http_header", title = @Translation("HTTP header"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **header_name / header_value / match_mode** — header_name (string), header_value (string) and match_mode (exact|contains|starts_with|ends_with|regex).
- Always also carries `id: http_header` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.http_header -> header_name, header_value, match_mode (all strings).
- Header name matching is case-insensitive; regex mode validates the pattern on submit and expects delimiters (e.g. /mobile-.*/i). Default match_mode is 'exact'.

## Matching

Reads the named request header and compares it to header_value using match_mode; returns FALSE (falls back to negate) when the header is absent.

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: http_header
    negate: false
    header_name: X-Consumer
    header_value: importer
    match_mode: exact
```

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
