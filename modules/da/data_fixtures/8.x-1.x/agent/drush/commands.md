<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (data_fixtures)

All operation is via Drush. There is **no UI, no route, no permission** — the roadmap mentions a
UI but none ships. Commands are defined twice: modern annotated commands in
`src/Commands/DataFixturesCommands.php` (registered in `drush.services.yml`, injected with the
`data_fixtures` / `FixturesManager` service) and a legacy `data_fixtures.drush.inc` providing the
same commands via `hook_drush_command()` callbacks. Both call the same `FixturesManager`.

Each annotated command is guarded by `@validate-module-enabled data_fixtures`.

## Commands

| Command | Aliases | Argument | Action |
|---|---|---|---|
| `fixtures:list` | `fixtures-list` | — | Prints each registered generator as `<alias> :: <FQCN>` (`prettyPrint()`). |
| `fixtures:load` | `fixtures-load` | `fixture_alias` | Calls `load()` on matching generators, in priority order. |
| `fixtures:unload` | `fixtures-unload` | `fixture_alias` | Calls `unLoad()` on matching generators, in **reverse** order. |
| `fixtures:reload` | `fixtures-reload` | `fixture_alias` | Runs `unload` then `load` for the alias. |

- **`fixture_alias`** — pass `all` to run every registered generator, or a specific generator
  **alias** (custom alias from the service tag, else the class short-name) to target just one.
- Load order: `FixturesManager::getGenerators()` returns generators sorted by ascending priority.
- Unload order: `getFixtures($alias, TRUE)` → `getGenerators(TRUE)` reverses the list, so content is
  torn down opposite to how it was built.
- Targeting by alias uses `array_filter()` on `getAlias() === $fixture_alias` (in
  `DataFixturesCommands::getFixtures()`), so an unknown alias simply matches nothing.

## Typical workflow

```bash
drush fixtures:list                 # see what's registered
drush fixtures:load all             # build all dummy content
drush fixtures:load articles        # build just the "articles" generator
drush fixtures:unload all           # remove all dummy content (reverse order)
drush fixtures:reload all           # rebuild from scratch
```

## Notes

- The legacy `.drush.inc` uses `drush_print()`; the annotated commands use `$this->output()`.
  Behaviour is equivalent. On current Drush the annotated `src/Commands` class is what runs.
- No confirmation prompt: `unload`/`reload` delete content immediately. Because generators run with
  `accessCheck(FALSE)` and can bulk-delete by entity type, run only against dev/test/CI databases.
