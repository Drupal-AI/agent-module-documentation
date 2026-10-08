<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Importer services

Eight services in `d7_import.services.yml`, all under namespace `Drupal\d7_import\Service`. Each
importer exposes `import(\DOMDocument $doc): array` returning `['imported','skipped','errors']`
(some add `updated`/`fid_map`), and a `purgeAll(): int`. `getElementValue()` is the shared helper
reading `$parent->getElementsByTagName($tag)->item(0)->textContent`.

| Service id | Class | Injected |
|------------|-------|----------|
| `d7_import.field_type_mapper` | `FieldTypeMapper` | — |
| `d7_import.vocabulary_importer` | `VocabularyImporter` | entity_type.manager, logger.factory |
| `d7_import.term_importer` | `TermImporter` | entity_type.manager, database, logger.factory |
| `d7_import.content_type_importer` | `ContentTypeImporter` | entity_type.manager, field_type_mapper, plugin.manager.field.field_type, logger.factory |
| `d7_import.file_importer` | `FileImporter` | entity_type.manager, database, file_system, logger.factory |
| `d7_import.node_importer` | `NodeImporter` | entity_type.manager, database, logger.factory |
| `d7_import.alias_importer` | `AliasImporter` | entity_type.manager, logger.factory |
| `d7_import.menu_importer` | `MenuImporter` | entity_type.manager, logger.factory, plugin.manager.menu.link, path.validator |

## ID preservation (the core trick)

`TermImporter`, `FileImporter`, `NodeImporter` keep D7 ids. Pattern:
1. `create([...id...])`, `enforceIsNew(TRUE)`, `save()`.
2. If `$entity->id() != $sourceId`, force the id with direct DB `update()` calls:
   - `NodeImporter::forceNid()` updates `node`, `node_field_data`, `node_revision`,
     `node_field_revision`, and every `node__field_%` / `node_revision__field_%` table
     (discovered via `$database->schema()->findTables()`), setting `nid` / `entity_id`.
   - `TermImporter::forceTid()` updates `taxonomy_term_data`, `taxonomy_term_field_data`,
     `taxonomy_term_revision`, `taxonomy_term_field_revision`, and `taxonomy_term__%` /
     `taxonomy_term_revision__%` tables.
   - `FileImporter` updates `file_managed`.
3. `repairAutoIncrement()` runs `SELECT MAX(id)` then `ALTER TABLE {…} AUTO_INCREMENT = max+1` so
   later inserts do not collide with the forced ids. (Values here are `(int)`-cast; conditions use
   the query builder.)

All queries use the `@database` query builder / parameterised `query()`; table names come from
`schema()->findTables()`, not from the XML.

## VocabularyImporter

Scans `<term>` elements for unique `<vocabulary>` values and creates any missing
`taxonomy_vocabulary` entity (`name` = title-cased vid, description "Imported from Drupal 7").
Existing vocabularies are skipped.

## TermImporter

Collects terms, then `orderByParent()` does a topological sort so a term is emitted only after its
parent (root parent = 0). Terms with a missing/cyclic parent are attached at root with a logged
warning rather than dropped. Skips terms with invalid `<tid>` or empty vocabulary. Preserves TID
via `forceTid`.

## ContentTypeImporter

`analyzeStructure(nodes.xml)` walks `<node>`/`<fields>/<field>` to derive, per content type, each
field's D7 `type`, `max_delta` (for cardinality) and — for `list_text`/`list_integer` — the set of
observed `allowed_values`. Then per type:
- creates the `node_type` if missing (name = title-cased machine name);
- loads/creates the default `entity_form_display` and `entity_view_display`;
- for each field: maps D7→D11 type via `FieldTypeMapper::getD11Type()`; **skips** unknown types and
  types whose providing module isn't installed (logged); creates `FieldStorageConfig`
  (cardinality −1 if `max_delta>0` else 1; storage settings from mapper) and `FieldConfig`
  (label from field name, settings from mapper); registers the field as a component on both
  displays.
`buildVocabularyMap()` resolves each `taxonomy_term_reference` field to a vocabulary by looking up
a referenced tid in taxonomy.xml.

### FieldTypeMapper (`src/Service/FieldTypeMapper.php`)

`getD11Type($d7Type)` uses a fixed `$typeMap` (returns NULL if unmapped):
text→string, text_long→text_long, text_with_summary→text_with_summary, image→image, file→file,
taxonomy_term_reference/entityreference/node_reference/user_reference→entity_reference,
link_field→link, date/datetime/datestamp→datetime, list_text→list_string,
list_integer→list_integer, list_boolean→boolean, number_integer→integer, number_decimal→decimal,
number_float→float, email→email, telephone/phone→telephone, video_embed_field→video_embed_field,
geofield→geofield, addressfield→address.
`getStorageSettings()` sets entity_reference `target_type` (node / taxonomy_term / user), string
max_length 255, list `allowed_values`. `getFieldSettings()` sets the reference `handler` /
`handler_settings.target_bundles` (vocabulary) and `display_summary` for text_with_summary.

## FileImporter

Per `<file>`: creates a `file` entity keeping the FID. `resolveSourcePath()` strips the D7 stream
scheme (`public://`/`private://`/`temporary://`) and joins onto the admin-provided
`sourceFilesPath`. If a source path is given and the file is missing, it logs a warning and skips
(no broken managed-file row). With no source path, only the DB row is created (assumes files
pre-synced). Copies with `FileSystem::copy(..., FileExists::Replace)`.

## AliasImporter

Per `<alias>`: builds system path `/node/{nid}` or `/taxonomy/term/{tid}`, alias `/`+path, langcode
(`und`→`en`, default `en`). **Upsert**: `loadByProperties(['path','langcode'])`; create if none,
else update the first entity's alias if it differs (skip if same). Extra duplicate aliases are left
in place with a warning. Resets storage cache every 500 rows.

## MenuImporter

`importMenus()` creates missing `system` `Menu` config entities; `importMenuLinks()` sorts links by
depth (parents first), converts D7 `link_path` to a D11 URI via `convertPath()` (`<front>`→
`internal:/`, `<nolink>`→`route:<nolink>`, http(s)/external passthrough, `node/N`→`entity:node/N`,
`taxonomy/term/N`, `user/N`, else `internal:/…`), and creates `menu_link_content` entities, mapping
D7 `mlid`→new UUID so children resolve their parent. Skips `shortcut-set-*` menus. `purgeAll()`
deletes all `menu_link_content` and non-core custom menus.

## NodeImporter

Per `<node>`: skips invalid nid or unknown content type (logged). Placeholder title for empty
titles. D7 uid 0 remapped to 1. Parses `<fields>/<field>` via `processFieldValues()` which switches
on the field `type` attribute to build D11 field value arrays (text/format mapping, image/file
`target_id` from fid, entity_reference target_id, link uri, address, geofield WKT/POINT, date
formatting to ISO-8601/UTC, etc.); unknown layouts are warned and skipped rather than passed raw.
Disables pathauto on the node's `path` field during save (aliases imported separately). Preserves
NID via `forceNid`. Progress notice every 100 nodes; entity-cache reset every 200.
