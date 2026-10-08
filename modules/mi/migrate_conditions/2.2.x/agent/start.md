<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Conditions — agent index

A framework for the **Migrate API**: a new `migrate_conditions_condition` plugin type plus
migrate **process** plugins that evaluate those conditions. You use it entirely from
migration YAML — no UI, config, permission, Drush command, or hook to implement.

- **Process plugins that take a `condition`: `evaluate_condition`, `skip_on_condition`,
  `stop_on_condition`, `if_condition`, `first_meeting_condition`, `filter_on_condition`,
  `switch_on_condition`, and their `:foreach` variants** →
  [plugins/process-plugins.md](plugins/process-plugins.md)
- **The built-in condition plugins, the `not:`/`parens`/`negate`/`source` shorthands, and how
  to write your own condition** → [plugins/condition-plugins.md](plugins/condition-plugins.md)

Key facts: condition manager service `plugin.manager.migrate_conditions.condition`; plugins
discovered from `Plugin/migrate_conditions/condition`; annotation
`@MigrateConditionsConditionPlugin` (`id`, `requires`, `parens`); base
`ConditionInterface::evaluate($source, Row): bool`. A process plugin's `condition` key is
either a plugin id string (`condition: empty`) or a map with a `plugin` key plus config.
Every process plugin with `handle_multiples` gains an auto-generated `<id>:foreach` variant
(`hook_migrate_process_info_alter`) that applies the condition per array element.
