<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `Commands\FastRevCommands` (final class extending `DrushCommands`), wired in `drush.services.yml`
(service `fast_revision_purge.commands`, tag `drush.command`) with the `purger`, `planner`, `index_manager`,
`table_map`, and `stats` services injected. Commands use PHP-attribute definitions (`Drush\Attributes`).

## `fastrev:report` (alias `fr:report`)

Runs the dry-run plan and prints KEEP/DELETE counts. First calls `IndexManager::ensureHelpfulIndexes()`, then
`Planner::plan(...)`, then reads the working-table counts and stats. Options (all cast to int/bool):

| Option | Default | Maps to |
|---|---|---|
| `--keep-last` | 5 | keep latest N non-default node revisions |
| `--since` | null | keep revisions since `YYYY-MM-DD` |
| `--protect-published` | false | protect latest published revision per node |
| `--per-language` | false | partition keep-last by `(nid, langcode)` |
| `--keep-paragraph-last` | 1 | keep last M paragraph revisions per entity |

Output: node KEEP/DELETE, paragraph IN_USE/DELETE, Layout Builder KEEP/DELETE (when those working tables exist),
potential reclaimable space, "Last Dry Run" / "Last Purged" (relative), and up to 10 sample vids/rids to delete.

```bash
drush fastrev:report --keep-last=5 --since=2024-01-01 --protect-published --per-language --keep-paragraph-last=1
```

## `fastrev:purge` (alias `fr:purge`)

Executes the purge via `Purger::purge($chunk, $sleep)`, then reads `space_freed_last_run` from stats. Options:

| Option | Default |
|---|---|
| `--chunk` | 5000 |
| `--sleep-ms` | 0 |

Output: node / paragraph revisions deleted, Layout Builder rows deleted, estimated bytes freed.

```bash
drush fastrev:purge --chunk=5000 --sleep-ms=50
```

Note: `fastrev:purge` purges according to the current plan/working tables and the injected purger; run
`fastrev:report` first to (re)compute the plan. It does not itself run the dedicated Paragraph/Layout Builder
truncators — those are the form's optional "Extra purges" batch ops.

## `fastrev:reindex` (alias `fr:reindex`)

Calls `IndexManager::ensureHelpfulIndexes()` to create the recommended planning/purge indexes (idempotent).

```bash
drush fastrev:reindex
```

## Operational notes

- Drush runs as a trusted CLI operator (server/shell access); these commands delete revisions permanently.
- On DDEV, prefix with `ddev` from the host (`ddev drush fastrev:report …`).
- Take a database backup before `fastrev:purge`; a common pattern is scheduling it from cron after validating a
  plan with `fastrev:report`.
