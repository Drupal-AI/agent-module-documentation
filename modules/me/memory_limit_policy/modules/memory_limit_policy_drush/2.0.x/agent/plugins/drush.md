<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `drush` condition plugin

Class `Drupal\memory_limit_policy_drush\Plugin\MemoryLimitConstraint\Drush`, annotated `@MemoryLimitConstraint(id = "drush", title = @Translation("Drush"))`. It implements the parent module's `MemoryLimitConstraint` plugin type (see the parent `agent/plugins/memory-limit-constraint.md`).

## Configuration

- Config key(s): **drush_commands** — a newline-separated string of Drush command names (one per line).
- Always also carries `id: drush` and `negate` (bool).
- Schema: memory_limit_policy.constraint.plugin.drush declares 'paths' in the shipped schema, but the plugin actually stores the value under 'drush_commands' (the schema key is stale).
- Known limitation: the override does not apply to some core Drush commands loaded very early (see issue #3276442). This submodule provides a Drush command service (drush.services.yml).

## Matching

For web requests the constraint's evaluate() is a no-op (returns only the negate flag). The actual CLI enforcement happens in a Drush command-event hook (MemoryLimitPolicyCommands::preCommandEvent) that runs before every Drush command, matches the command name/aliases against the configured list, and applies the policy memory via ini_set().

## Add it to a policy

Add an entry to a `memory_limit_policy` entity's `policy_constraints`:

```yaml
policy_constraints:
  - id: drush
    negate: false
    drush_commands: "migrate:import"
```

## CLI enforcement (command-event hook)

The actual memory override for Drush is applied by `MemoryLimitPolicyCommands::preCommandEvent()` (service `memory_limit_policy_drush.commands`, tagged `drush.command`, `@hook command-event *`). Before each Drush command it loads enabled policies, sorts by weight, and for every `drush` constraint whose configured commands intersect the current command name/aliases it calls `ini_set('memory_limit', $policy->getMemory())`. The constraint's own `evaluate()` is a web no-op returning only `isNegated()`. Caveat: some core commands loaded very early are not covered (#3276442).

The policy applies its `memory` only when this constraint (and every other constraint on the policy) passes; `negate: true` inverts this one. See the parent `agent/api/evaluation.md` for the full evaluation order.
