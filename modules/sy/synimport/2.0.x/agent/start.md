<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynImport (synimport) — agent index

**Drush-only import/export of Drupal content (nodes, commerce products, taxonomy, menus, custom blocks, media, files) to/from a directory of structured YAML files. Package "Synapse".**

- **Version:** 2.0.x (2.0.5) · **Core:** `^11 || ^12` · **License:** GPL-2.0-or-later
- **Dependencies:** `idna`. Soft/runtime (used only if present + configured on the site): `commerce_product`, `paragraphs`, `media`, `pathauto`, `path_alias`, `file`. None of these except `idna` are declared in `synimport.info.yml`.
- **Interface:** Drush commands only — `drush.services.yml` registers `\Drupal\synimport\Drush\Commands\SynimportCommands`. NO routes, NO permissions, NO config forms, NO config schema.
- **Config it touches (not defines):** may set `system.site:page.front` (node `is_front`) and write an arbitrary config object's `form_bg` key (synlanding).

## What it provides
- **Drush commands** (see [drush/commands.md](drush/commands.md)): `synexport`, `synexport:{taxonomy,node,product,block}`, `synimport`, `synimport:{redis_import,contacts,taxonomy,node,menu,product,block,synlanding_config}`.
- **Services** (all in `synimport.services.yml`, tagged internal helpers):
  - Export: `synimport.export` (Export), `synimport.export.create_yml` (CreateYml → CreateYmlBase), `synimport.export.{taxonomy,node,product,block}`.
  - Import: `synimport.import` (Import), `synimport.import.create_entity` (CreateEntity), `synimport.import.files` (Files), `synimport.import.{taxonomy,menu,node,product,block,redis}`.
  - `synimport.log` (Logger — console/colored output), `synimport.logger` (core LoggerChannel "synimport").
- **Utility:** `\Drupal\synimport\Utility\EmptyDirException` (thrown when an import dir is missing/empty).

## Solution docs
- [drush/commands.md](drush/commands.md) — every command with name, alias, arguments and defaults.
- [services/import.md](services/import.md) — import flow, YAML field typing, entity creation, file handling, Redis integration, supported entity types.
- [services/export.md](services/export.md) — export flow, entity→YAML mapping, field-type detection, banned fields, file copying.

## Notes vs prior 8.x-1.x docs
- `core_version_requirement` narrowed from `^8 || ^9 || ^10 || ^11` to `^11 || ^12`.
- `provides_drush_commands` is **true** (8.x-1.x data.json wrongly said false); `provides_config_schema` is **false** (module ships no `config/` at all).
- Import command is `synimport:contacts` (not `:contact`) and there is a `synimport:redis_import <app_id> <source>` command.
