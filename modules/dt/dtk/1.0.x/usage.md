<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush DTK ("Drush Token Killer") provides opt-in, token-saving output compression for common core and contrib Drush commands, built for AI agents.

---

Drush DTK shrinks the output of frequently-run, read-only Drush commands so that AI coding agents (and humans) spend far fewer tokens reading them. It adds no everyday commands and changes nothing by default: compression is opt-in and is switched on per command with the `--ai-compress` flag, per session with the `DTK_COMPRESS=1` environment variable (recommended for agents), or permanently with the `dtk.settings` `compress` config value. When active, lightweight Drush hooks select a compact set of `--fields` and force `--format=csv` (dropping the wide ASCII-table chrome) for each supported command, but only when the user has not already requested their own output. `--no-ai-compress` beats every opt-in and restores native output, and `DTK_COMPRESS=0` (also `false`/`no`/`off`) disables it while overriding the config. A one-time `drush dtk:install <agent>` helper wires the opt-in into an AI agent's project configuration. Requires Drush ^13; some contrib rows (Devel) require Drush 13.7+.

---

- Reduce the token cost of Drush output consumed by AI agents.
- Enable compact output for a single command with `drush pml --ai-compress`.
- Enable compact output for a whole session with `export DTK_COMPRESS=1`.
- Turn compression always-on with `drush config:set dtk.settings compress 1`.
- Restore native output on demand with `--no-ai-compress` (beats every opt-in).
- Disable per session with `DTK_COMPRESS=0` (also `false`, `no`, `off`), overriding config.
- Get a compact module list from `pm:list` (`--fields=name` or `name,status`, CSV).
- See only actionable rows from `core:requirements` (`--severity=1`, `title,severity`, CSV).
- Get short state tokens (`only_db`, `different`, `only_sync`) from `config:status`.
- Trim `watchdog:show` to `type,severity,message` in CSV.
- Trim `user:information` to `uid,name,mail,user_status` in CSV.
- Trim `field:base-info` to `field_name,field_type,required,cardinality`.
- Compact `field:types`, `field:formatters`, `field:widgets` to id/label (native YAML kept).
- Compact `role:list` (native YAML) to `rid,label` in CSV.
- Compact `updatedb:status`, `migrate:status`, `migrate:messages`, `views:list` output.
- Compact `search-api:list`, `search-api:status`, `search-api:server-list` output.
- Compress Devel's Symfony-native `devel:services` and `devel:token` (via the console listener).
- Compress contrib commands only when the owning module is installed.
- Wire `DTK_COMPRESS=1` into Claude Code with `drush dtk:install claude`.
- Wire `DTK_COMPRESS=1` into Codex with `drush dtk:install codex`.
- Print the manual opt-in step for OpenCode or Copilot with `drush dtk:install opencode|copilot`.
- Enable the site-wide config opt-in automatically when running inside a container (DDEV, Lando, Docker).
- Force the site-wide config opt-in with `drush dtk:install <agent> --site-wide`.
- Keep humans at a terminal unaffected until they explicitly opt in.
