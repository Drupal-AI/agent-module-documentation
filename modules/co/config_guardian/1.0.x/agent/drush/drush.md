<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_guardian — Drush commands

Registered via `drush.services.yml` (tag `drush.command`,
`Commands\ConfigGuardianCommands`). Require Drush (CLI). No web permission check —
CLI access is the trust boundary.

| Command | Aliases | Args / options |
|---|---|---|
| `config-guardian:snapshot <name>` | `cg-snap`, `cgsnap` | `--type=manual`, `--description=` |
| `config-guardian:list` | `cg-list`, `cglist` | `--limit=20`, `--type=`, `--format=table` |
| `config-guardian:rollback <id>` | `cg-rollback`, `cgroll` | `--dry-run`, `--force`, `--no-backup` |
| `config-guardian:analyze` | `cg-analyze`, `cganal` | `--format=table` |
| `config-guardian:diff <id1> <id2>` | `cg-diff`, `cgdiff` | — |
| `config-guardian:export <id> <path>` | `cg-export` | writes snapshot JSON to `<path>` |
| `config-guardian:delete <id>` | `cg-delete` | `--force` |

Notes:
- `rollback` always runs a simulation first and prints create/update/delete counts +
  risk level/score. Without `--force` it prompts for confirmation; without
  `--no-backup` it creates a `pre_rollback` backup snapshot first.
- `analyze` reports pending create/update/delete, risk score/level, risk factors,
  and detected conflicts.
- `export <id> <path>` calls `file_put_contents($path, ...)` — a local filesystem
  write; run it as a user with appropriate shell/file permissions.
