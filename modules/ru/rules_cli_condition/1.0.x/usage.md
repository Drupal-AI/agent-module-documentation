<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rules CLI condition adds a single Rules condition plugin that evaluates TRUE when the current PHP environment is the command line.
---
The Rules module lets site builders attach conditions to reaction rules. Sometimes a rule should behave differently (or be skipped) when triggered from Drush / cron on the CLI versus a normal web request. This module supplies a "Command-line environment" condition (in the System group) that simply returns `PHP_SAPI === 'cli'`, so a rule can test whether it is running in a CLI context.

The condition plugin (`RulesCliCondition`, id `rules_cli_condition`) extends `RulesConditionBase` and takes no context parameters. There is no configuration, routes, permissions or services — it is a tiny building block for the Rules UI. Combine it with negation to make a rule that only runs for web requests, or use it directly to branch CLI-only logic. Setup: enable the module (requires the Rules module), then add the condition from the System group when editing a rule.
---
- Test whether a Rules reaction is running on the command line.
- Skip a rule during Drush/cron CLI execution.
- Restrict certain rule actions to web requests (via negation).
- Branch rule logic between CLI and HTTP contexts.
- Add the "Command-line environment" condition from the System group.
- Prevent CLI-triggered rules from sending web-only notifications.
- Guard interactive-only actions against background CLI runs.
- Build automation that differs between cron and user requests.
- Use with other Rules conditions to compose environment-aware logic.
- Keep the check config-free and dependency-light.
- Disable specific reaction rules during Drush-triggered events.
- Detect cron runs that execute under the CLI SAPI.
- Avoid duplicate side effects between web and CLI rule triggers.
- Gate debug/logging actions to CLI runs only.
- Document environment assumptions directly in the rule configuration.
