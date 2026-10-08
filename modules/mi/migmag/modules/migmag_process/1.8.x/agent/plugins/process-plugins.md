<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_process — migrate process plugins

Reference each in a migration's `process:` block by its `plugin:` id. Classes live in
`Drupal\migmag_process\Plugin\migrate\process\*`. Discover them at runtime via the core
process plugin manager: `\Drupal::service('plugin.manager.migrate.process')->getDefinitions()`.

## `migmag_lookup` (`MigMagLookup`)

Smarter drop-in for core `migration_lookup`. Only creates **valid** stubs; identifies which
migration actually contains the source row; can stub from **partial** source IDs; supports
`stub_default_values` (destination values keyed for the stub, pulled from the host row).
Same base config as core `migration_lookup` (`migration`, `source_ids`, `no_stub`, …) plus
`stub_default_values`.

## `migmag_try` (`MigMagTry`)

Wrap a sub-pipeline in try/catch.
- `process`: the pipeline to run.
- `catch`: array of return values keyed by exception FQCN (default `['Exception' => NULL]`).
- `multiple`: handle multiple values (default FALSE).
- `saveMessage`: save the migrate message like core would when catching MigrateException /
  MigrateSkipRowException (default TRUE).

## `migmag_compare` (`MigMagCompare`)

Compare two source values.
- `operator`: PHP comparison operator, default `===`.
- `return_if`: map of `true`/`false` return values (default booleans; `<=>` returns int).
- `multiple`: default FALSE. Pair with `skip_on_empty` to conditionally skip a pipeline.

## `migmag_target_bundle` (`MigMagTargetBundle`)

Resolve a destination bundle from bundle-type migrations.
- `source_entity_type`: row property holding the source entity type id.
- `source_lookup_migrations`: bundle migrations to search, keyed by that entity type.
- `destination_entity_type`: default `@entity_type`.
- `null_if_missing`: return NULL when no result (default FALSE → returns incoming value).

## `migmag_get_entity_property` (`MigMagGetEntityProperty`)

Return a property/field value of an existing entity.
- `entity_type_id` (required), `property` (required — a field, or an allowed getter such as
  `uuid`, `id`, `label`, `bundle`, `toArray`, …).
- `load_revision` / `load_translation` (optional). Returns NULL if the entity/property is
  missing or the getter isn't allowed (`static::ALLOWED_GETTERS`).

## `migmag_uuid_generate` (`MigMagUuidGenerate`)

If the input string contains a valid UUID, extract and return it; otherwise generate a new UUID.

## `migmag_logger_log` (`MigMagLoggerLog`, `handle_multiples = TRUE`)

Log the live value passing through a pipeline (`message`: sprintf-compatible). For debugging.

```yaml
process:
  destination:
    plugin: migmag_logger_log
    message: 'value is %s'
    source: foo
```
