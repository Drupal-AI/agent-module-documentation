<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy Drush adds a `drush` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on the drush commands.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `drush`, class `Drush`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: drush` plus a newline-separated string of Drush command names (one per line). The plugin's `evaluate()` decides whether the constraint matches the current request: For web requests the constraint's evaluate() is a no-op (returns only the negate flag). The actual CLI enforcement happens in a Drush command-event hook (MemoryLimitPolicyCommands::preCommandEvent) that runs before every Drush command, matches the command name/aliases against the configured list, and applies the policy memory via ini_set(). Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.drush declares 'paths' in the shipped schema, but the plugin actually stores the value under 'drush_commands' (the schema key is stale). Known limitation: the override does not apply to some core Drush commands loaded very early (see issue #3276442). This submodule provides a Drush command service (drush.services.yml).

---

- Raise memory only for `migrate:import` runs.
- Give `cache:rebuild` more memory on a large site.
- Scope a high limit to long-running `queue:run` commands.
- Match a command by any of its aliases (the hook checks aliases too).
- List several Drush commands (one per line) in one constraint.
- Apply CLI-only memory without affecting web requests.
- Negate to apply memory to all commands except the listed ones.
- Bump memory for a custom module's Drush command.
- Keep quick commands on the default limit while heavy ones get more.
- Give `config:import` extra headroom during deployments.
- Export the drush policy as config for deployment pipelines.
- Diagnose OOM that only happens under a specific Drush command.
- Set a different limit for CLI than the web subscriber applies.
- Target `search-api:index` batch indexing runs.
- Give `pm:security` or update commands more memory.
- Note the early-loaded core commands caveat (#3276442) when scoping.
