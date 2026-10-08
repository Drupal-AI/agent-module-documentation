<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Base — shared services & traits

All classes are in the `Drupal\tome_base` namespace. Nothing here is configurable; these are
building blocks reused by `tome_static` and `tome_sync`.

## `CommandBase` (abstract)
Base class every Tome Drush command extends (`StaticCommand`, `ExportCommand`, `ImportCommand`,
`StaticPreviewCommand`, `TomeSuperCacheRebuildCommand`, …). Provides the shared `--uri`
handling, the resolved `$this->executable`, and the concurrent-process helpers below.

## Traits
- `ProcessTrait` — `runCommand()` / `runCommands()` run one or many `Symfony\Component\Process\Process`
  instances with a bounded concurrency (`process-count`) and per-process retry (`retry-count`),
  invoking a callback as each finishes. This is how `tome:static` and `tome:export` fan work
  out across worker subprocesses.
- `ExecutableFinderTrait` — locates the PHP / Drush executable used to spawn those workers.
- `PathTrait` — path and URI helper methods (e.g. joining/normalising export paths).

## Drush service
`cli.workaround` → `Drupal\tome_base\Commands\CliWorkaroundCommands` (registered in
`drush.services.yml`). Its `@hook pre-command php:cli` iterates `Drush::getApplication()->all('tome')`
and re-adds any non-`AnnotatedCommand` Tome command as an `AnnotatedCommand`, so that
`drush php` (php:cli) does not choke on Tome's Symfony console commands. `@internal`, a
temporary workaround for a Drush bug; you never call it directly.

There is no `tome_base.services.yml` beyond this — the reusable pieces are traits/base classes
consumed by the other sub-modules, not standalone services.
