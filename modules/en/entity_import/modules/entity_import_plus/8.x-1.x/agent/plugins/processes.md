<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Process plugins + stub event subscriber

All three plugins live in `src/Plugin/migrate/process/`, extend a `migrate_plus` process plugin, implement
`Drupal\entity_import\Plugin\migrate\process\EntityImportProcessInterface`, and use
`EntityImportProcessTrait` — that combination is what makes them selectable/configurable on an Entity Import
field mapping (the parent's `EntityImportProcessManager` discovers every process plugin implementing that
interface).

## `entity_import_plus_entity_lookup` — `EntityImportPlusEntityLookup`

Extends migrate_plus `EntityLookup`; label "Entity Lookup". Resolves an inbound value to an existing
entity's ID for a reference destination.

- Config form fields: `entity_type` (fieldable types only), `bundle[]` (multi), `value_key` (the field to
  match, filtered so it exists in all chosen bundles), `bundle_key` (value), `ignore_case`, and `operator`
  (`IN`/`STARTS_WITH`/`ENDS_WITH`/`CONTAINS`). AJAX-rebuilt.
- Overridden `query()`: runs an entity query with the chosen operator and bundle condition, **always calls
  `->accessCheck()`**. `IN` supports multiple values (else throws for non-IN + multiple). When
  `ignore_case` is off it post-filters results by exact main-property value. Returns a single ID or an
  array of `[destinationProperty => id]` for multiple matches.

## `entity_import_plus_entity_generate` — `EntityImportPlusEntityGenerate`

Extends migrate_plus `EntityGenerate` (itself a subclass of EntityLookup); label "Entity Generate". Same
config form (`entity_type`, `bundle[]`, `value_key`, `bundle_key`, `ignore_case`). When the lookup finds no
match it **creates** the referenced entity and returns its new ID — useful for auto-creating referenced
terms/entities during import.

## `entity_import_plus_str_replace` — `EntityImportPlusStrReplace`

Extends migrate_plus `StrReplace`; label "String Replace". Config: `search` and `replace` textareas
(one term per line), `regex` and `case_insensitive` checkboxes. `validateConfigurationForm()` requires equal
counts of search and replace lines. `formatReplacementToArray()` trims each line and expands a `CHR:<n>`
token (n in 0–255) into `chr($n)` so control characters can be searched/inserted. Defaults are empty
`search`/`replace` arrays.

## Stub event subscriber — `EntityImportPlusEventSubscriber`

Service `entity_import_plus.event_subscriber`. Subscribes to
`EntityImportEvents::ENTITY_IMPORT_PREPARE_MIGRATION_STUB`. Because Entity Import instantiates process plugins
against a stub migration, `onPrepareMigrationStub()`:

- for `entity_import_plus_entity_lookup` / `…_entity_generate`, sets `destination => ['plugin' => 'entity:node']`
  (EntityLookup's constructor makes calls that need a destination), and
- for `entity_import_plus_str_replace`, sets empty `search`/`replace` (StrReplace throws on invalid initial
  config).

These are stub defaults only; the real per-field-mapping settings are applied when the migration actually runs.
