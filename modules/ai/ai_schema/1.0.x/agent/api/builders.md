<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema — builder services API

Six stateless builder services (`ai_schema.services.yml`, namespace `Drupal\ai_schema\Service`). Each exposes `build(): array` returning a JSON-serializable structure. Call them directly to embed exports in your own code without Drush.

## Services
- **`ai_schema.builder`** → `EntityExportBuilder`. Core builder. `build()` returns `{format_version, generator_version, generated_at, entities[]}`. Each entity: `{id: "type.bundle", entity_type, bundle, label, base_table, revision_table, translatable, revisionable, fields[]}`. Each field: `{name, field_type, normalized_type, label, required, multiple, reference?, ai_hint?, storage?}`.
  - `resolveBundleIds(string $entityTypeId): string[]` — public helper used by the other builders.
  - `resolveLabel(mixed): string` — resolves TranslatableMarkup, preferring the untranslated (English) string when the `en` language exists.
  - Type normalization via `NORMALIZED_TYPE_MAP` → string/text/integer/decimal/boolean/datetime/reference/file/image/list. Semantic role inference via `SEMANTIC_ROLE_MAP`, `SEMANTIC_PREFIX_RULES` and field-type rules (e.g. `field_image*`→media, `field_price*`→price, taxonomy/media/user reference targets).
- **`ai_schema.relation_graph`** → `RelationGraphBuilder`. `build()` → `{format_version, generated_at, summary:{node_count,edge_count}, nodes[], edges[]}`. Edges are `entity_reference` / `entity_reference_revisions` / `dynamic_entity_reference` fields: `{from, to, field, type, multiple}`; `to` is `target.*` when no target bundles are constrained.
- **`ai_schema.storage_map`** → `StorageMapBuilder`. `build()` → `{..., summary:{entity_count,unique_table_count}, tables:{ "type.bundle": {base_table,data_table,revision_table,revision_data_table, field_tables:[{field,table,columns}] } }}`. Uses the entity's `SqlContentEntityStorage` table mapping.
- **`ai_schema.compact`** → `CompactModelBuilder` (depends on `ai_schema.builder`). `build()` → compact per-entity map with a `legend`. Field shorthand string: `<short-type>[!][[]][>target] [#role]` (e.g. `str! #label`, `ref[]>taxonomy_term #taxonomy`).
- **`ai_schema.sql_query`** → `SqlQueryBuilder`. `build()` → `{..., queries:{ "type.bundle": {base_table, select} }}`. `select` is a multi-line `SELECT … FROM <base> LEFT JOIN <field-table> …` string built from the table mapping (column/table/bundle names come from the site's own entity/field storage definitions, not from request input).
- **`ai_schema.per_entity`** → `PerEntityExportBuilder`. Fans the five builders out and keys a combined payload per `entity.bundle`: `{id, generated_at, entity, relations:{outgoing,incoming}, storage, compact, sql}`.

## Robustness
Every builder wraps per-entity / per-field work in `try/catch (\Throwable)` and logs warnings to `@logger.channel.default`, so a single broken field or plugin does not abort the whole export.
