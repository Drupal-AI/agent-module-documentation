<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy Environment Variable adds a `env_variable` policy condition to Memory Limit Policy: a plugin to set memory limit policy based on an environment variable.

---

This submodule registers a single `MemoryLimitConstraint` plugin (id `env_variable`, class `EnvVariable`) for the parent Memory Limit Policy module. It contributes no UI of its own beyond the constraint's configuration form, which is embedded in the parent's add/edit-policy flow at `/admin/config/performance/memory-limit-policy`. Its config is stored inside a `memory_limit_policy` entity's `policy_constraints` list as a map keyed by `id: env_variable` plus name (the environment variable to read) and values (a sequence of exact strings or regex patterns; empty matches any value). The plugin's `evaluate()` decides whether the constraint matches the current request: Reads $_ENV[name]; returns FALSE if unset; TRUE if values is empty (variable just needs to exist); otherwise TRUE when the value equals one of the configured values or matches one as a case-insensitive regex. Combine it with other constraints in a policy (all must pass, logical AND) and with `negate` to invert it. Schema: memory_limit_policy.constraint.plugin.env_variable -> name (text), values (sequence). Matching uses the PHP superglobal $_ENV, so the variable must be exported into the PHP environment.

---

- Raise memory only when `APP_ENV=migration` is set.
- Apply more memory on a specific environment (staging vs prod) via an env var.
- Match any value of a variable by leaving the values list empty.
- Use a regex to match a family of environment values.
- Scope memory to a CI/build environment identified by an env var.
- Negate to apply memory when the variable is absent or non-matching.
- Combine with a Path constraint to target a path only in one environment.
- Drive memory from a container/orchestrator-provided variable.
- Keep production on a tight limit while a migration env gets more.
- List several accepted values (one per line) for one variable.
- Export the env policy as config and let the environment decide at runtime.
- Diagnose OOM that only appears under a particular deployment flag.
- Give a data-import environment extra headroom without code changes.
- Match `DEPLOY_STAGE` values like `blue`/`green`.
- Use with weight so the env policy overrides a broad default.
- Toggle a high-memory policy purely via infrastructure config.
