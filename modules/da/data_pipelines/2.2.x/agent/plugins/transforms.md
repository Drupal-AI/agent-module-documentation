<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pipelines, transforms & validation

A **pipeline** is a code plugin that a dataset references. It declares which validation
constraints and transform plugins run over each `DatasetData` record.

## Declaring a pipeline (YAML)

Pipelines are discovered from a file named `{module}.data_pipelines.yml` in a module root
(discovery via `DatasetPipelinePluginManager`, service `plugin.manager.data_pipelines_pipeline`;
plugin class defaults to `DatasetPipelineBase`). Top-level keys per pipeline id: `label`,
`transforms` (`field` + `record`), `validations` (`field` + `record`), and optional
`destinationSettings`. Example (`tests/modules/data_pipelines_test/data_pipelines_test.data_pipelines.yml`
and README):

```yml
a_pipeline:
  label: 'A data pipeline'
  transforms:
    field:
      some_field:
        - plugin: map
          map: { Y: true, N: false }
    record:
      - plugin: concat
        fields: [lastname, firstname]
        as: full_name
        separator: ', '
  validations:
    record:
      ItemCount: { expectedCount: 3 }
    field:
      firstname:
        NotBlank: { message: 'Firstname is required' }
        Length: { min: 3 }
```

## Pipeline runtime (`src/DatasetPipelineBase.php`)

- `validate(DatasetData)` — only runs if `hasValidation()`. Builds a `MapDataDefinition` of type
  `data_pipelines_data`, attaches each field's constraints (as `string` properties) and the
  record-level constraints, then returns typed-data `->validate()` violations. (Field validation
  is string-typed only.)
- `transform(DatasetData)` — runs **record** transforms first, then each **field**'s transform
  sequence. Each entry needs a `plugin` key; remaining keys become plugin configuration. Missing
  or unknown plugin ids are logged and skipped.
- `getDestinationSettings($destination_id)` — per-pipeline overrides merged into the destination
  plugin at process time.

## Transform plugins (`data_pipelines_transform`)

Attribute `#[DatasetTransform(id, fields: bool, records: bool)]`
(`src/Attribute/DatasetTransform.php`); base `Transform\TransformPluginBase` implements
`transformField()`/`transformRecord()`, gated by `supportsFields()`/`supportsRecords()`, with
`doTransformField()`/`doTransformRecord()` for subclasses. Ships:

- **`map`** (`Plugin/DatasetTransform/MapValues.php`, `fields: TRUE`) — replaces a field value via
  a `map` config array when the key matches.
- **`concat`** (`Concat.php`, `records: TRUE`) — joins the values of `fields` with `separator`
  into a new field named by `as` (defaults to a random name).
- **`remove`** (`Remove.php`, `records: TRUE`) — unsets each field in `fields`.
- **`skip`** (`Skip.php`, `records: TRUE`) — throws `TransformSkipRecordException` to drop a record
  when `field` `===` `value` (or `!=` when `not_equals` is TRUE), removing it from output.

## Bundled validation constraints

- **`ItemCount`** (`Plugin/Validation/Constraint/ItemCount.php` + `ItemCountValidator.php`) —
  record constraint asserting an exact `expectedCount` of items.
- **`JsonPath`** (`JsonPathConstraint.php` + `JsonPathConstraintValidator.php`) — validates the
  JSON source's `*_path_to_data` field is a parseable JSONPath expression.
- Any core field constraint (`NotBlank`, `Length`, `Regex`, …) may be used in `validations.field`.

The `invalid_values` dataset field (`retain` | `remove`) decides whether records that were
previously valid but now fail validation are kept or purged from destinations.
