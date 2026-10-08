<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What the shipped plugins cover

Enumerate the live IDs on a site with `drush dmu-list TYPE`. This is the source-tree inventory
(2.0.0-alpha2) so you know what analyze/upgrade actually attempts.

## Indexers (`Plugin/DMU/Indexer`, 4)

`Functions`, `Classes`, `Constants`, `FunctionCalls` — build the in-memory map every other plugin reads.

## Analyzers (`Plugin/DMU/Analyzer`, ~13)

Read-only issue flaggers, each linking to drupal.org change records:

- `Grep` — flags common renamed functions/globals/constants (does not grep exhaustively; flags
  unconditionally and defers to the Grep converter).
- `FunctionCall` (+ `FunctionCallDeriver`) — deprecated/moved D7 API calls.
- `InfoFile` — `.info` → `.info.yml` differences.
- `HookPermission`, `HookUninstall`, `HookFormAlter` — specific hook migrations.
- `FlagHook` (+ `FlagHookDeriver`) — hooks that simply no longer exist / changed.
- `DB` (+ `DBDeriver`) — database API changes.
- `PSR4` — class-file layout / autoloading.
- `Tests` — SimpleTest → PHPUnit.

## Converters (`Plugin/DMU/Converter`, ~28 top-level + ~59 `Functions/` + 2 routing)

**Deprecated plugin type, still what `dmu-upgrade` runs.** In-place rewriters. Highlights:

- Structure: `InfoToYAML`, `PSR4`, `Blocks`, `Tests`, `UnitTests`, `Links`, `Routing`.
- Hooks: `HookPermission`, `HookMenuAlter`, `HookInit`, `HookBoot`, `HookExit`, `HookWatchdog`,
  `HookUserLogin`, `HookLibrary`, `HookFormAlter`, `HookEntityInfo`, `HookEntityTypeView`,
  `HookNodePrepare`, `HookFieldFormatterInfo`, `HookFieldWidgetInfo`, the `HookFieldAttach*` family,
  `HookURLOutboundAlter`, `EntityHooks`, `UserHooks`.
- `Grep` — data-driven search-and-replace from `config/install/drupalmoduleupgrader.grep.yml`.
- `Functions/` (~59) — one converter per D7 procedural call: `Watchdog`, `VariableAPI`/`VariableSet`,
  `CacheGet`/`CacheSet`, `DbSelect`/`DbInsert`/`DbUpdate`/`DbDelete`/`DbQueryRange`/`DbQueryTemporary`,
  `EntityLoad`/`EntityCreate`/`EntityGetInfo`, `UserLoad`/`UserSave`/`UserAccess`, `CommentLoad`,
  `LoadMultiple`, `ModuleInvoke`/`ModuleInvokeAll`, `GetT`, `DrupalMessageSet`, `DrupalGetTitle`,
  `FieldInfoFieldTypes`/`FieldInfoWidgetTypes`/`FieldUpdateField`/`FieldViewField`/`FieldViewValue`,
  `FormStateDefaults`/`FormLoadInclude`, `ThemeGetRegistry`, and more.

## Fixers (`Plugin/DMU/Fixer`, ~11)

Reusable Pharborist edits used by converters: `CreateClass`, `Implement`, `ImplementHook`, `Delete`,
`Define`, `Disable`, `Notify`, `HookToYAML`, `FormCallbackToMethod`, `PSR4`.

## Rewriters (`Plugin/DMU/Rewriter`, 3)

`Generic` (+ `GenericDeriver`) and `FormState` — type-aware getter/setter substitution (e.g. rewrite
`$form_state['values']` access to `$form_state->getValues()`).

## Filtering runs

Every command takes `--only=ID,ID` (run exactly these) or `--skip=ID,ID` (run all but these), matched
against the IDs from `dmu-list`. Use this to re-run a single converter, or to exclude one that produces
bad output on a particular codebase.
