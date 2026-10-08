<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme-switch migration, component-version healing, Drush commands

Source: `src/EventSubscriber/ActiveThemeChangeSubscriber.php`,
`src/Commands/VarbaseComponentsCommands.php`, `src/Hook/VarbaseComponentsHooks.php`,
`varbase_components.services.yml`, `drush.services.yml`.

## ActiveThemeChangeSubscriber

Service `varbase_components.active_theme_change_subscriber`. Constructor args (both this and the Drush
command service): `@messenger, @config.factory, @theme_handler, @logger.factory, @database,
@entity_type.manager, @entity_field.manager`. Subscribes to `ConfigEvents::SAVE` →
`onActiveThemeChange()`.

### Guard conditions (all must hold)
1. Saved config name is `system.theme`.
2. Original data has a `default` key.
3. `default` actually changed (`$old_theme !== $new_theme`).
4. **Both** old and new themes declare `auto_switch_components: true` in `<theme>.info.yml`
   (`themeHasFlag()` reads the theme path from the theme handler, `file_get_contents` + `Yaml::decode`,
   requires the flag `=== TRUE`).

### Migration steps (in order), then a status message
`onActiveThemeChange()` runs:
- `replaceAndSaveThemeInActiveConfigs($old,$new)` → `processEntityViewDisplayConfigs()` first, then
  `processAllConfigs()`. `processConfigWithPatterns()` encodes each config to YAML and runs regex
  replacements: (a) `themes/(contrib|custom)/<old>/` → the new theme's real path (from
  `themeHandler->getTheme()->getPath()`); (b) colon-style plugin IDs `\w+:<old>:\w+` and
  `(^|\s|'|")<old>:\w+`; (c) dot-style `sdc.<old>.` → `sdc.<new>.`. Configs named
  `canvas.component.sdc.<old>*` are **skipped** (owned by the old theme; renaming would cause UUID
  conflicts). A second pass, `processDependenciesInConfig()`, swaps `<old>`→`<new>` inside
  `dependencies.theme` arrays only for configs that don't already contain the old name.
- `migratePageRegions($old,$new)` — clones `canvas.page_region.<old>.<region>` config entities to
  `<new>.<region>` (skips if the new one exists; drops `uuid`/`_core` so the entity API recalculates).
  Bails if the `page_region` entity type (Canvas) is absent.
- `replaceThemeInContentEntityComponentFields($old,$new)` — for every content entity type with a
  `component_tree` field, rewrites the `component_id` column from `sdc.<old>.` to `sdc.<new>.` in each
  field data + revision table (SQL-backed storage only), row by row via the query builder.
- `replaceThemePathsInTextFields($old,$new)` — in `text`/`text_long`/`text_with_summary` value/summary
  columns, `REPLACE()` old `themes/(contrib|custom)/<old>/` paths with the new theme path. Guards each
  update with a `LIKE` count and `escapeLike()`; the `REPLACE()` expression uses `:old`/`:new`
  placeholders.
- `fixComponentVersionsInConfigs($new)` and `fixComponentVersionsInContentEntities($new)` — heal (below).

All writes go through Drupal's DB abstraction (`select/update`, `expression()` with placeholders); table
and column names come from the entity table mapping, not from input. Theme names come only from the
saved `system.theme` config or a Drush arg (CLI/root), and are `preg_quote`d before use in a regex.

## Component-version healing

`heal(?string $theme = NULL)` resets the `component` storage cache, then
`fixComponentVersionsInConfigs('', TRUE)` (empty prefix + `$all_components = TRUE` → validate every
component reference, not just one theme's SDC) and `fixComponentVersionsInContentEntities(NULL)`.

`fixComponentVersionsInArray()` (recursive) finds arrays holding both `component_id` and
`component_version`; if the component is a Canvas `VersionedConfigEntityInterface` and the stored
version is neither its `getActiveVersion()` nor in `getVersions()`, it is rewritten to the active
version. Content is repaired the same way per field table (`fixVersionColumnInTable()`), caching each
component's active/known versions. Purpose: Canvas regenerates SDC component config entities on rebuild
and logs "Component version … not found, falling back to active version" for any stale hash; healing
removes that noise and keeps the Canvas editor layout API from rejecting a page.

### When healing runs automatically (`VarbaseComponentsHooks`)
- `#[Hook('rebuild')]` → `healComponentVersions()`.
- `#[Hook('modules_installed')]` → heal (skipped when `$is_syncing`).
- `#[Hook('themes_installed')]` → heal.
- `healComponentVersions()` bails unless the `canvas` module exists, resolves the subscriber service and
  calls `heal()`, wrapping errors to the `varbase_components` log.
The `.install` sets `module_set_weight('varbase_components', 10)` so these hooks run **after** Canvas has
regenerated the components (so healing sees current versions). `varbase_components_update_10001()`
re-applies that weight.

## Drush commands (`VarbaseComponentsCommands`)
Service `varbase_components.drush_commands`. Each command rebuilds an `ActiveThemeChangeSubscriber`
(`buildSubscriber()`) and invokes its protected methods via `ReflectionMethod` (`callMethod()`).

- `varbase-components:switch-theme <old_theme> <new_theme>` (aliases `vc-switch`, `vcs`;
  option `--dry-run`). Aborts if `<new_theme>` is not installed. Not dry-run: runs
  `replaceAndSaveThemeInActiveConfigs`, `replaceThemeInContentEntityComponentFields`,
  `replaceThemePathsInTextFields`, resets `component` cache, then `fixComponentVersionsInConfigs`.
  Dry-run: counts configs/entity rows referencing the old theme (`dryRunConfigScan`/`dryRunEntityScan`).
- `varbase-components:fix-versions <theme>` (aliases `vc-fix-versions`, `vcfv`). Resets the component
  cache, `fixComponentVersionsInConfigs($theme, TRUE)` (all component references, incl. `block.*`/`js.*`)
  and `fixComponentVersionsInContentEntities(NULL)`. The general "repair everything" entry point.
- `varbase-components:scan-refs <theme>` (aliases `vc-scan`, `vcscan`). Read-only audit → `RowsOfFields`:
  lists configs whose serialized raw data contains the theme name (marking
  `canvas.component.sdc.<theme>*` as "component definition — expected") and `component_tree` field
  tables with `sdc.<theme>.%` rows.

## Opting a theme in
Add to both the source and destination `<theme>.info.yml`:

```yaml
auto_switch_components: true
```

If either theme lacks it, `onActiveThemeChange()` returns without doing anything (the Drush commands run
regardless of the flag).
