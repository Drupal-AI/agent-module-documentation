<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How conversion works (`Drupal\convert_bundles\ConvertBundles`)

All logic is static methods on `Drupal\convert_bundles\ConvertBundles`. The form orchestrates
them inside a Batch; you can call them directly. Conversion is two phases: **rewrite the bundle
column in the DB**, then **reload and copy field values**.

## Field discovery / mapping

- `getEntities($type, array $bundles)` — entity-query loads all entities of the given
  bundle(s) for an entity type (uses the type's `bundle` key).
- `getToFields($fields_to)` → `['fields_to_names' => …, 'fields_to_types' => …]` — target field
  labels + the **data type** of each field's main property (used to filter compatible targets).
  Always includes the two synthetic targets `remove` and `append_to_body`.
- `getFromFields($fields_from_bundle, $fields_to_names, $fields_to_types)` — builds a `select`
  per non-base source field, whose options are only targets with a matching data type.
- `sortUserInput($user_input, $fields_new_to, $fields_from)` → `map_fields` + `update_fields`
  (fields kept as-is vs. remapped).

## Phase 1 — rewrite the bundle column (direct DB writes)

- `getBaseTableNames($entity_type)` / `getFieldTableNames($entity_type, $fields_from)` — resolve
  the base/data tables and the dedicated field + field_revision tables.
- `convertBaseTables($entity_type, $base_table_names, $ids, $to_type, &$context)` — `UPDATE`
  the entity's base and data tables, setting the `bundle`/`type` key to the target for the
  selected ids.
- `convertFieldTables($field_table_names, $ids, $to_type, $update_fields, &$context)` — for
  fields that stay (same field on both bundles), updates the `bundle` column in their dedicated
  field tables so the stored data still belongs to the entity under its new bundle.

## Phase 2 — copy mapped values (entity API)

`addNewFields($entity_type, $ids, $limit, $map_fields, $fields_to, $entities, &$context)` runs
in Batch: it flushes caches (so the new bundle's fields are recognised), then for each entity
reloads it, and for each mapping:

- `remove` → skipped.
- `append_to_body` → appends the labelled source value to the `body` field; a `media`
  entity-reference becomes a `<drupal-media data-entity-uuid="…">` embed.
- `create_new` → sets a fixed/default value on a new target field.
- otherwise → `$entity->set($target_field, $old_entity->get($source_field)->getValue())`.
- `datetime` values are reformatted to `Y-m-d` when either side is a `datetime` field.

Revisionable entities get a **new revision** (`createRevision`/`setNewRevision(TRUE)`); revision
-log entities get the message `Converted from <old> to <new>.`. Just before `save()`, the module
fires `hook_convert_bundle_alter($old_entity, &$new_entity)` (see [../hooks/alter.md](../hooks/alter.md)).

## Minimal programmatic conversion

For a single entity where fields line up you can rewrite the bundle column and re-save, but the
supported path is the wizard/action. The essential end state is that the entity's `bundle`/`type`
key equals the target bundle and mapped field values are present on the new bundle's fields.
