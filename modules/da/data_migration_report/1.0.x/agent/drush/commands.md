<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands & verification workflow

Registered by `drush.services.yml` as `data_migration_report.commands` →
`\Drupal\data_migration_report\Commands\DataMigrationReportCommands` (extends `DrushCommands`).
Constructor args: `@database`, `@extension.path.resolver`, `@state`, `@file_system`,
`@file_url_generator`, `@renderer`, `@entity_field.manager`.

## 1. `generate:content-mapping` (alias `gcm`)

`generateContentMapping()`. Requires a working source connection (else aborts with a link to the
credentials form). For each D7 module that is enabled in the source `system` table
(`getDrupal7ModuleStatus()`), it enumerates bundles and writes a mapping YAML:

- `user` (user/user), `node` (per `{node_type}`), `taxonomy_term` (per `{taxonomy_vocabulary}`),
  `block_custom`, `comment` (`comment_node_<type>` per node type), `menu_links` (per
  `{menu_custom}`), `url_alias`, `file` + `file_private`, `field_collection_item` (per
  `field_collection` field), `paragraphs_item` (per `{paragraphs_bundle}`).
- `contentTypeFields()` reads D7 fields from `field_config`/`field_config_instance` and D10 fields
  from `EntityFieldManager::getFieldDefinitions()` (only `FieldConfigInterface` instances).
- `getDestinationMapping()` maps source type/bundle to destination entity type, bundle, and the
  `migrate_map_*` table (e.g. `field_collection_item`/`paragraphs_item` → `paragraph`;
  `block_custom` → `block_content` basic; `menu_links` → `menu_link_content` with a
  main-menu/management/navigation/user-menu bundle map; `url_alias` → `path_alias`;
  `file_private` → `file`).
- `generateMappingYaml()` writes `public://data_migration_report/migration-mapping/<entity_type>/<entity_type>_<bundle>.yml`
  with `source`, `table`, `fields[]` (each `d7`/`d10` name+type), `destination`. If the file exists
  and differs it prompts to overwrite; identical files are skipped.

Mapping YAML shape:
```yaml
source: { entity_type: node, bundle: article }
table: migrate_map_d7_node_complete__article
fields:
  - d7: { name: body, type: text_with_summary }
    d10: { name: body, type: text_with_summary }
destination: { entity_type: node, bundle: article }
```

## 2. `migration:test <entity_type> <bundle>` (alias `mt`)

`migrationTesting()`. Options: `--limit` (int, cap rows) and `--ids` (list of source IDs).
Example: `drush mt node article --limit=10` or `drush mt node page --ids=12,34`.

Steps:
1. Load the bundle's mapping YAML (aborts if missing) and verify the source connection.
2. Fetch D7 source IDs with a per-entity SQL query (`--ids` adds an `IN (:ids[])` clause; `--limit`
   adds `LIMIT`). Source/destination ID correlation comes from the mapping `table`
   (`sourceid1`/`destid1`).
3. `getEntityValues()` builds per-entity SELECTs joining base columns + field tables, using
   `getFieldColumnList()` + `field_types.yml` (`getFieldTypeColumnMapping()`) to expand each field
   into its D7/D10 columns. `getValues()` runs the query against the D7 (`sourceDatabaseConnection`)
   or D10 (`@database`) connection; `prepareAssociativeArray()` keys rows by entity id and collapses
   multi-value columns into arrays.
4. `executePreprocess()` runs normalizers so equivalent values do not read as errors:
   - Field-type methods (dynamically dispatched from field type): `email`, `datetime`,
     `textLong`/`textWithSummary` (strip `\r\n\t`), `link` (`_uri`→`_url`, `_options`→`_attributes`),
     entity-reference family (`userReference`/`nodeReference`/`taxonomyTermReference`/`file`/`image`
     → `preprocessEntityReference`), `entityReferenceRevisions`.
   - Field-name remap for renamed fields (`preprocessFieldName` / `fieldNameMapping`).
   - Entity-type methods: `entityUser` (role id remap via `migrate_map_d7_user_role`, `roles_target_id`→`rid`),
     `entityNode` (`langcode`→`language`), `entityTaxonomyTerm` (vocabulary remap, description/format
     renames), `entityComment`, `entityMenuLinkContent`, `entityBlockContent`, `entityPathAlias`.
5. Compare each source row's columns (minus the id column) against the mapped destination row.
   Mismatches, and records with no/missing destination, are collected into `$errors` keyed by
   source id and D7 field.
6. `total`/`passed`/`failed` are computed; the summary is printed with a Symfony Console `Table`.

## Report output

The error data is rendered through the `migration_report` theme
(`templates/migration-report.html.twig`, prepared by `template_preprocess_migration_report()`) via
`renderer->renderInIsolation()` and saved as
`public://data_migration_report/migration-reports/<entity_type>/migration_report-<entity_type>-<bundle>.html`.
The report is a standalone HTML page (Chart.js + jQuery from CDN) with Basic Information, a
Summary pass/fail pie, a per-field error bar chart, and a collapsible Issues list showing D7 vs
destination values for each failing record. The absolute file URL is logged on success.

Operational note: mapping and report files are written under the site's **public files**
directory. Treat generated reports as migration diagnostics and remove them from any
internet-facing environment when finished.
