<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring and running Advanced Sanitize

## Install & enable

```bash
composer require drupal/advanced_sanitize   # pulls fakerphp/faker ^1.9.1
drush en advanced_sanitize -y
```

No Drupal module dependencies. Grant **`administer advanced_sanitize configuration`** to whoever
configures/runs it (permission is `restrict access: true`).

## Settings

Config object **`advanced_sanitize.settings`** (schema:
`config/schema/advanced_sanitize.edit.yml`), edited at
**`/admin/config/development/sanitize-settings`** (`SanitizeSettingsForm`):

| Key | Type | Meaning |
|---|---|---|
| `config_path` | string | Path to the YAML definition file, **relative to Drupal root**. The form validates the file exists (`fileSystem->realpath(DRUPAL_ROOT . '/' . path)`). |
| `batch_entity_limit` | int | Entities processed per Batch operation (default `AdvancedSanitizeInterface::LIMIT` = 100). |
| `batch_sql_limit` | int | Table rows processed per Batch operation (default 100). |

The form's **Sanitize** submit (`::launchSanitize`) runs `service->sanitize(FALSE)` immediately (no
`drush_backend_batch_process`). Saving without a path shows a warning.

## The definition file (YAML)

The file is a top-level **list** of records. Each record is either an *entity record* or an *SQL
(table) record* — the code distinguishes them by which keys are present (`entity_id` vs
`table_name`; a record with both is ignored). See
`web/modules/contrib/advanced_sanitize/examples/advanced_sanitize.config.sample.yml`.

### Entity record

```yaml
- entity_id: user            # entity type id
  bundle_id: default         # a bundle machine name, or 'default' for the whole type
  field_mapping:
    - field_id: mail         # must be a real field on the bundle/type or it is dropped
      data_provider: faker   # 'faker' | 'constant' (entity records ignore 'sql'/'expression')
      method: safeEmail      # faker: FakerPHP method name
      parameters: []         # faker: optional positional args passed to the method
      locale: en_GB          # faker: optional locale for this field's Faker instance
      ignore_field_values:   # skip rows whose current value is in this list
        - 'keep-me@example.com'
      ignore_entity_id: [1]  # skip these entity ids
      ensure_unique: true    # prepend uniqid() to the generated value
    - field_id: field_note
      data_provider: constant
      value: 'redacted'      # constant: the literal replacement value
```

Processing (`AdvancedSanitizeService::processWithDrupal()`):
- Only `FieldableEntityInterface` entities; **empty fields are left empty**.
- `bundle_id: default` (`PLACEHOLDER_BUNDLE`) validates against
  `getFieldStorageDefinitions()` and adds **no** `type` condition (all bundles); any other bundle
  validates against `getFieldDefinitions()` and adds `condition('type', bundle_id)`.
- Entity query uses `accessCheck(FALSE)` (sanitize must reach every row).
- `faker` → `entity->set(field_id, fakeValue)`; `constant` → `entity->set(field_id, value)`; the
  entity is saved once if anything changed. Data providers other than `faker`/`constant` are no-ops
  for entity records even though `sql` passes validation.
- If the entity type is revisionable, `sanitizeRevisions()` writes the sanitized field values onto
  **all** revisions.

### SQL (table) record

```yaml
- table_name: some_table
  unique_column: id          # required: the row identifier column
  where: "created > :arg1"    # optional raw SQL WHERE condition
  where_args:                 # optional args for the WHERE
    ':arg1': 0
  column_mapping:
    - col_name: email
      data_provider: faker
      method: safeEmail
      locale: nl_NL
      ensure_unique: true
    - col_name: status
      data_provider: constant
      value: 'x'
      ignore_field_values: ['keep']   # adds a NOT IN condition on this column
    - col_name: score
      data_provider: expression       # table records only
      expression: ':a + :b'
      expr_arguments:                  # NOTE: code reads 'expr_arguments'
        ':a': 1
        ':b': 2
```

Processing (`AdvancedSanitizeService::updateRow()` per row id from
`select(table_name)->addField(unique_column)`):
- `faker` → generated value; `constant` → literal `value`; both go into a single
  `db->update(table_name)->fields(...)`.
- `expression` → `query->expression(col_name, expression, expr_arguments)` (raw SQL expression).
- `ignore_field_values` on a column adds a `NOT IN` condition so matching rows are skipped.
- `ensure_unique` prepends `uniqid()`.

### Faker details

`getFakerData()` calls `faker->unique()->format($method, $parameters ?? [])`; `initFaker()` builds a
Faker instance with the record/column `locale` or `en_US` by default. `locale` only applies when
`data_provider: faker`.

## Running it

- **UI:** the **Sanitize** button on the settings form (synchronous, foreground batch).
- **Drush:** `drush advanced_sanitize:sanitize` (alias `drush adsan`) — `AdvancedSanitizeCommands`;
  runs `service->sanitize()` (background batch via `drush_backend_batch_process()`). Both paths
  warn and abort if `config_path` is empty.
- On finish, `finishBatch()` runs `drupal_flush_all_caches()` and shows a success message.

## Events

Subscribe to `Drupal\advanced_sanitize\Event\AdvancedSanitizeEvents` constants:

| Constant | Event name | Payload class | Fired |
|---|---|---|---|
| `STARTED_SANITIZE` | `advanced_sanitize.process.started` | `StartedSanitizeEvent` | after configs validated, before `batch_set` (configs by ref) |
| `PREPROCESS_DEFINITION` | `advanced_sanitize.process.preprocess_definition` | `PreprocessDefinitionEvent` | per definition before it is batched (definition by ref) |
| `PRE_SANITIZE` | `advanced_sanitize.entity.pre_sanitize` | `PreSanitizeEvent` | before an entity field is changed |
| `POST_SANITIZE` | `advanced_sanitize.entity.post_sanitize` | `PostSanitizeEvent` | after an entity field is changed |
| `PRE_SANITIZE_REVISION` | `advanced_sanitize.revision.pre_sanitize` | `PreSanitizeRevisionEvent` | before a revision is rewritten |
| `POST_SANITIZE_REVISION` | `advanced_sanitize.revision.post_sanitize` | `PostSanitizeRevisionEvent` | after a revision is rewritten |
| `FINISHED_SANITIZE` | `advanced_sanitize.process.finished` | `FinishedSanitizeEvent` | from the batch finish callback |

`StartedSanitizeEvent::getSanitizeConfigs()` and `PreprocessDefinitionEvent::getSanitizeConfig()`
return by reference (`&$event->getSanitizeConfigs()`) so a subscriber can mutate the run.

## Gotchas

- The example file uses `expr_args`, but `updateRow()` reads **`expr_arguments`** — use
  `expr_arguments` or the `expression` provider errors on the missing key.
- `sanitizeRevisions()` conditions revisions on `condition('type', getEntityType()->getKey('id'))`,
  which is not a bundle value; on non-`type`-keyed or non-bundled entity types this revision query
  can behave unexpectedly. Verify revision output on your entity types.
- Entity records silently ignore `data_provider: sql`/`expression` (only `faker`/`constant` act);
  raw SQL expressions work only on `table_name` records.
- `config_path` is read with `file_get_contents(DRUPAL_ROOT . '/' . path)` and the file must be
  inside/reachable from the Drupal root; the form validates existence, not YAML validity.
- The completeness of anonymization is entirely defined by your YAML — the module ships no default
  field list. Enumerate every PII-bearing field/column yourself.
