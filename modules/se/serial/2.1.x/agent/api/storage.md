# Serial — allocation mechanism & the storage service

## The `serial.sql_storage` service

Class `Drupal\serial\SerialSQLStorage` implements `SerialStorageInterface`
(`SerialStorageInterface::SERIAL_FIELD_TYPE = 'serial'`). Injected with
`entity_type.manager`, `entity_field.manager`, `logger.factory`. Get it with
`\Drupal::service('serial.sql_storage')`.

Key methods:

- `createStorageName($entityTypeId, $bundle, $fieldName)` → the assistant table name,
  `serial_<md5("{entityType}_{bundle}_{field}")>` (md5 keeps it within MySQL's 64-char limit).
- `createStorageFromName($name)` / `dropStorageFromName($name)` — create/drop the assistant
  table.
- `generateValue(FieldDefinition, entity)` / `generateValueFromName($name)` — allocate the
  next number.
- `initOldEntries($entityTypeId, $bundle, $fieldName, $startValue)` — back-fill existing
  entities; returns how many were updated.
- `getAllFields()` — field map for the `serial` type; `getSchema()` — the assistant-table
  schema.

## How a number is allocated (atomic)

Each serial field has its own **assistant table** `serial_<hash>` with columns:
`sid` (DB type `serial` = AUTO_INCREMENT, primary key) and `uniqid` (varchar, unique). To get
the next value (`generateValueFromName`):

1. Start a DB transaction.
2. `INSERT` a row with a fresh `uniqid()` → the AUTO_INCREMENT hands back a unique `sid`.
3. Periodically (`$sid % 10 == 0`) delete older rows to keep the table small.
4. Return `sid`.

Because the uniqueness comes from the database engine's AUTO_INCREMENT, allocation is atomic
and safe under concurrent entity creation — no read-modify-write race.

## When the value is set

`SerialItem::preSave()` calls `getSerial()`. It allocates only when the entity `isNew()` (or,
on multilingual sites, `isNewTranslation()`). The stored value is
`generated_sid + start_value - 1`, so `start_value` shifts the sequence's origin.

## Lifecycle hooks (in `serial.module`)

- `serial_field_config_create(FieldConfig)` — on creating a `serial` field, builds the
  assistant table via the service.
- `serial_field_config_delete(FieldConfig)` — drops the assistant table.
- `serial_schema()` (in `serial.install`) — declares assistant tables for all existing serial
  fields at install time.
- `serial_clone_node_alter()` — clears serial field values when a node is cloned so the copy
  gets a new number.
- `serial_field_info_alter()` — sets category "Number" on older (<10.2) core.

The field type is computed/read-only from the editor's perspective (`propertyDefinitions`
marks the value computed + required; `isEmpty()` never treats it as empty for numeric values).
There are no hooks the module invites you to implement and no Drush commands.
