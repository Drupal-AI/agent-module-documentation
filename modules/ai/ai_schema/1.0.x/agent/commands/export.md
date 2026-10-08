<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema — Drush commands & output files

All functionality is Drush-driven. Commands are defined in `src/Commands/AiSchemaCommands.php` (registered via `drush.services.yml`, tag `drush.command`). There is no admin UI, route, or permission.

## Install
```
composer require drupal/ai_schema
drush en ai_schema
```
Requires Drush 12 or 13.

## Commands
| Command | Arg | Default output | Builds |
| --- | --- | --- | --- |
| `aischema:export` | `[path]`, `--compact` | `entity-export.json` | Entity/field definitions (`--compact` drops per-field `storage`) |
| `aischema:relations` | `[path]` | `relation-graph.json` | Reference-edge graph |
| `aischema:storage` | `[path]` | `storage-map.json` | Table/column map per bundle |
| `aischema:compact` | `[path]` | `compact-model.json` | Token-efficient LLM model |
| `aischema:sql` | `[path]` | `sql-queries.json` | Generated SELECT statements |
| `aischema:per-entity` | `[dir]` | `entities/<type>.<bundle>.json` | Combined per-bundle file |
| `aischema:export-all` | `[dir]` | all of the above + `entities/` | Everything |

## Output location
Default root is `dirname(DRUPAL_ROOT) . '/ai-schema'` (i.e. `ai-schema/` next to the web root). Every command accepts an explicit path/dir argument to override. `writeJson()` creates missing directories (`mkdir 0755`) and drops a `.gitignore` (`*` + `!.gitignore`) into the export root so exports are not committed by default. Files are encoded with `JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES`.

## What is exported
Only entity types whose class implements `FieldableEntityInterface` and (for storage/SQL) whose storage is `SqlContentEntityStorage`. Bundles are resolved via `EntityExportBuilder::resolveBundleIds()` (bundle info → bundle entity storage → fallback to the entity type id). Errors per entity/field/bundle are caught and logged as warnings to the default logger channel; the command continues.

## Notes for operators
- Run as a user who can write the output directory.
- After adding fields/entity-types, `drush cr` then re-run.
- The generated SQL in `sql-queries.json` / per-entity `sql` is text for humans/LLMs; it is not executed by the module.
