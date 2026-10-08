<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DMU Drush commands

Defined in `src/Commands/DrupalmoduleupgraderCommands.php`, registered via `drush.services.yml`
(service `drupalmoduleupgrader.commands`, tag `drush.command`). Three commands. There is **no web
UI, no route, no permission** — the module is CLI-only. Run from the modern Drupal root, with the
target **Drupal 7** module placed in `/modules` (or pointed at with `--path`).

## `dmu:analyze` (alias `dmu-analyze`) — read-only report

```
drush dmu-analyze MODULE_NAME [--only=…] [--skip=…] [--path=…] [--output=…]
```

- Builds a `Target` for the module and runs `buildIndex()` (all Indexer plugins).
- Runs each Analyzer plugin's `analyze($target)`; every returned `Issue` is added to a `Report`.
- If any issues, renders the `dmu_report` theme to HTML and `file_put_contents()` to the destination:
  `--output PATH` if given, else `<module-dir>/upgrade-info.html`.
- Modifies **nothing** in the target's code; the only file written is the report.
- Options: `--only` = comma-separated analyzer IDs to run exclusively; `--skip` = IDs to exclude;
  `--path` = explicit module path; `--output` = report destination.

## `dmu:upgrade` (alias `dmu-upgrade`) — in-place conversion (destructive)

```
drush dmu-upgrade MODULE_NAME [--backup] [--only=…] [--skip=…] [--path=…]
```

- Locates the module directory, warns if a `<module>.info.yml` already exists ("You have already run
  dmu upgrade command for this module").
- With `--backup`, mirrors the whole module directory to `<base-path>.bak` (Symfony Filesystem) first.
- Iterates the Converter plugins; for each whose `isExecutable($target)` is true, calls
  `convert($target)`, which **edits the module's files in place** (writing new YAML, new `src/` classes,
  rewriting function bodies, etc.). Exceptions from a converter are logged and the loop continues.
- `--only` / `--skip` filter which converters run. **No dry-run mode** — the change is the effect.

## `dmu:list` (alias `dmu-list`) — enumerate plugins

```
drush dmu-list PLUGIN_TYPE [--only=…] [--skip=…]
```

- `PLUGIN_TYPE` is one of the plugin managers: `indexer`, `analyzer`, `converter`, `fixer`, `rewriter`.
- Returns the plugin IDs of that type (respecting `--only`/`--skip`). Use it to discover valid IDs to
  pass to `--only`/`--skip` on the other two commands.

## How the target module is found

`dmuGetDirectory()` recursively walks `DRUPAL_ROOT/modules` and `DRUPAL_ROOT/sites` looking for a file
named exactly `MODULE_NAME.info` (the **Drupal 7** info filename). The directory containing it becomes
the base path. `--path` bypasses this search and uses the supplied path directly. Because the tool
targets D7, it keys off `.info`, not `.info.yml`.
