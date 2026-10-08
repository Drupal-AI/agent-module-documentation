<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `wm:redirect:*` — redirect management

`RedirectCommands` (`modules/drush_webmaster_redirect/src/Drush/Commands/RedirectCommands.php`) over
`RedirectManager` (`src/Service/RedirectManager.php`). Requires the base module + contributed
Redirect module. Enable: `drush en drush_webmaster_redirect -y`.

| Command | Aliases | Args / options |
|---|---|---|
| `wm:redirect:list` | `wm-rl`, `wm:r:list` | `--status-code --language --enabled --limit(50) --offset` |
| `wm:redirect:get` | `wm-rg`, `wm:r:get` | `rid` (detailed: uuid, uid, created, hash) |
| `wm:redirect:search` | `wm-rs`, `wm:r:search` | `query` `--search-field(source\|target\|both) --limit(50)` |
| `wm:redirect:find` | `wm-rf`, `wm:r:find` | `source` `--language` (exact source match) |
| `wm:redirect:add` | `wm-ra`, `wm:r:add` | `source` `target` `--status-code(301) --language --dry-run` |
| `wm:redirect:update` | `wm-ru`, `wm:r:update` | `rid` `--source --target --status-code --language --enabled --dry-run` |
| `wm:redirect:delete` | `wm-rd`, `wm:r:delete` | `rid` `--dry-run` |
| `wm:redirect:stats` | `wm-rst`, `wm:r:stats` | — (total, enabled, disabled, by_status_code) |
| `wm:redirect:import` | `wm-rim`, `wm:r:import` | `file`(CSV) `--update-existing --dry-run` |
| `wm:redirect:export` | `wm-rex`, `wm:r:export` | `--file --status-code --language` (CSV to file, else YAML to stdout) |

## `RedirectManager` behaviour

- **Storage/repository:** loads the `redirect` entity storage and uses
  `@redirect.repository->findMatchingRedirect()` for source lookups. Queries use the entity query
  API with `accessCheck(FALSE)`.
- **Status codes** validated against `VALID_STATUS_CODES = {300,301,302,303,304,305,307,308}`;
  default on add is **301**.
- **Path normalisation:** `normalizePath()` strips a leading `/` from sources; `validateTarget()`
  keeps `http(s)://` targets as-is and converts internal paths to an `internal:/…` URI.
- **Duplicate guard:** `createRedirect()` refuses if a redirect already matches the source
  (returns the existing one); `updateRedirect()` refuses a source change that would collide with a
  different redirect.
- **Search** loads up to 1000 redirects and filters in PHP with case-insensitive `str_contains`
  (the Redirect module doesn't do LIKE queries well).
- **CSV import** (`wm:redirect:import`): the command parses the file with `fopen`/`fgetcsv`, requires
  `source` + `target` header columns, then `RedirectManager::importRedirects()` creates each row
  (301/all-languages default), updating existing sources only with `--update-existing`, and returns
  created/updated/skipped/errors counts. **CSV export** writes `source,target,status_code,language`
  rows with `fputcsv` to `--file`, or returns the list as YAML on stdout.

## Notes for agents

- These commands print through `RowsOfFields`/`PropertyList` formatters (so `--format=yaml`/`json`
  is available via Drush) rather than the base module's hand-built YAML.
- The import/export file paths are ordinary CLI file arguments (server-side read/write); this is a
  local admin tool, so treat file locations as trusted operator input.
