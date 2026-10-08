<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rules CLI condition (rules_cli_condition) — agent index
**Provides one Rules condition that is TRUE when Drupal runs under PHP CLI.**

- **Version:** 1.0.x
- **Core:** ^10.4 || ^11.1
- **Depends on:** rules
- **Plugin:** `@Condition` id `rules_cli_condition` "Command-line environment" (System group); `RulesCliCondition::doEvaluate()` returns `PHP_SAPI === 'cli'`. No context params.
- **Routes / permissions / config / services:** none.

**Security:** No routes, input, or configuration; a pure environment check. No security findings.
