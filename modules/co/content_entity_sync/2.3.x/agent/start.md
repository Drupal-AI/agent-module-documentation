<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Entity Sync — agent index

info.yml name **Content Entity Sync**, version **2.3.0**, package `Core`, core `^10 || ^11`.
Dependency: core `field`. Composer also requires `drush/drush ^12 || ^13`.

**What it is:** a Drush-only tool that exports content entities (nodes, terms, any content
entity type) to per-entity YAML files and re-imports them on another site — filling the gap
Drupal config sync leaves (config syncs, content does not). There is **no web UI, no route, no
permission, no config schema, no admin form** — the entire interface is two Drush commands.
Not covered by the Drupal security advisory policy.

## Commands (`src/Drush/Commands/ContentEntitySyncCommands.php`)

- `content_entity_sync:export <entity_type>` (aliases `conex`, `cox`)
  - `--bundle=` filter by bundle (comma-separated → `IN`).
  - `--ids=` comma-separated entity IDs. **Bug:** the ids branch reads `$options['bundle']`
    not `$options['ids']` (`ContentEntityExportHandler::results()`), so `--ids` does not work
    as documented.
  - Writes one YAML file per entity into the sync directory.
- `content_entity_sync:import <entity_type>` (aliases `conim`, `coi`)
  - `--bundle=` skip files whose loaded entity is not of that bundle.
  - Reads every `*.yml` in the sync directory whose filename first dotted segment matches
    `<entity_type>`, decodes it, and upserts.

Both commands resolve the target directory from `Settings::get('content_sync_directory')`
(set in `settings.php`, e.g. `$settings['content_sync_directory'] = '../content/sync';`) and
throw if it is not an existing directory. There is no default — the setting is required.

## Services (`content_entity_sync.services.yml`)

- `content_entity_sync.entity.serializer` → `ContentEntitySerializer` — entity → array:
  writes `uuid/langcode/type/bundle/id`, computes config `dependencies` (bundle type +
  `field.field.*`) and an `entity` dependency list from entity-reference `target_id`s,
  collapses single-cardinality / single-`value` fields, and emits per-language `translations`.
- `content_entity_sync.export` → `ContentEntityExportHandler` — runs an entity query with
  **`accessCheck(FALSE)`**, yields loaded entities, serializes, and `file_put_contents` a file
  named `{type}.{bundle}.{uuid}.yml`.
- `content_entity_sync.import` → `ContentEntityImportHandler` — `scandir` the directory,
  `Yaml::decode` each file, then `upsert()`: loads the existing entity by `content['id']`;
  if fieldable it `->set()`s every field from `content['fields']` (stripping array keys that
  start with `_`) and saves, else `->create()`s a new entity from `bundle` + `fields`; then
  `handleTranslations()` adds/updates each translation. (services.yml passes the serializer as
  a 2nd constructor arg, which the import handler's 1-arg constructor ignores.)

## File format

YAML keys: `uuid`, `langcode`, `type` (entity type id), `bundle`, `id`, `dependencies`
(`config`/`entity`), `fields` (name → normalized value), and `translations` (langcode → field
values) for translatable entities. Filename encodes type/bundle/uuid; import matches files by
the leading `type` segment.

## Operational notes

- CLI-only and privileged: whoever can run Drush can export any content (access checks are
  bypassed on export) and import can **overwrite** existing entities in place. Run imports
  deliberately as part of a reviewed deployment.
- YAML files are trusted local input (decoded with `Yaml::decode`, no PHP object
  instantiation). `import` mass-assigns whatever fields the YAML contains onto the target
  entity — treat the sync directory contents as trusted, the same as a config sync directory.
- No network transport, no HTTP client, no credentials, no remote endpoint.

## Related docs

- Human setup guide → [`../human-docs/index.md`](../human-docs/index.md),
  [`../human-docs/installation/index.md`](../human-docs/installation/index.md)
- Usage summary → [`../usage.md`](../usage.md)
