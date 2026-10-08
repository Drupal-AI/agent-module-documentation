<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/HackedCommands.php` (registered via `drush.services.yml`). All read
project data from core's `update` module, then download + hash each release to compare.

| Command | Aliases | Args / options | Output |
|---|---|---|---|
| `hacked:list-projects` | `hlp`, `hacked-list-projects` | `--force-rebuild` | Table of every project: title, name, version, status (Unchanged/Changed/Unchecked), changed count, deleted count |
| `hacked:details` | `hd`, `hacked-details` | `<machine_name>` `--include-unchanged` | Per-file status for one project |
| `hacked:diff` | `hacked-diff` | `<machine_name>` `--diff-options=…` | Unified diff of changed files (shells out to system `diff` between the clean download and the local copy) |
| `hacked:lock-modified` | `hacked-lock-modified` | — | No-op (kept for BC; `pm-updatecode` locking was deprecated) |

Examples:

```bash
drush hacked:list-projects                 # full integrity report as a table
drush hlp --force-rebuild                   # ignore the cached report, re-download
drush hacked:details token                  # which token files differ
drush hd token --include-unchanged          # include unchanged files too
drush hacked:diff token                      # unified diff for the token project
```

Notes:
- The full report is cached in the `hacked` cache bin (key `hacked:drush:full-report`) for ~1
  day; use `--force-rebuild` to bypass it.
- `hacked:details`/`hacked:diff` validate the `<machine_name>` and error if the project is
  unknown.
- `hacked:diff` requires the system `diff` binary to be available to PHP.
