<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity.data service API

Service id **`entity.data`** → `Drupal\entity_data\EntityData` (`src/EntityData.php`), implementing
`Drupal\entity_data\EntityDataInterface`. Injected: `@database`, `@config.factory`. Tag `backend_overridable`
(swap the backend by overriding the service). Access it with
`\Drupal::service('entity.data')` or inject `entity.data`.

## Install / enable

`composer require drupal/entity_data` then `drush en entity_data`. `hook_schema()` creates the `entity_data`
table on install. No configuration is required to use the service (see [config/settings.md](../config/settings.md)
only if you store objects).

## Storage

Table **`entity_data`** (`entity_data.install`): `entity_id` (varchar), `module` (varchar), `entity_type`
(varchar), `name` (varchar 128), `value` (big blob), `serialized` (tinyint). Primary key
`(entity_id, module, name, entity_type)`; indexes on `module`, `name`, `entity_type`. All reads/writes use
the Drupal DB API (`select()->condition()`, `merge()`, `delete()->condition()`) — parameterized, no raw SQL.

## Methods

### `set($module, $entity_id, $name, $entity_type, $value)`

Upserts one row via `merge()` keyed on `(entity_id, module, entity_type, name)`. If `$value` is **not
scalar** it is `serialize()`d and the `serialized` column is set to 1; scalars are stored as-is.

### `get($module, $entity_id = NULL, $name = NULL, $entity_type = NULL)`

Selects rows filtered by whichever of `module`/`entity_id`/`name`/`entity_type` are non-empty, then shapes the
return by which arguments were supplied:

- `module` + `entity_id` + `name` + `entity_type` → the single stored value, or `NULL`.
- `module` + `entity_id` + `entity_type` → `[name => value]` for that entity.
- `module` + `name` → `[entity_type][entity_id] => value]`.
- `module` + `entity_id` (no type) → `[entity_type][name] => value]`.
- `module` + `entity_type` → `[entity_id][name] => value]`.
- `module` only → `[entity_type][entity_id][name] => value]`.

Each row is decoded by the protected `getValue()`: if `serialized`, it calls
`unserialize($value, ['allowed_classes' => ...])` where allowed classes come from config (default `FALSE`, so
objects decode to `__PHP_Incomplete_Class` unless explicitly allowed — see
[config/settings.md](../config/settings.md)); otherwise the raw string is returned.

### `delete($module = NULL, $entity_id = NULL, $name = NULL, $entity_type = NULL)`

Deletes matching rows. Each supplied argument is cast to an array and matched with an `IN` condition, so you
may pass a single value or an array (e.g. several module names or entity ids) per parameter. With no arguments
it deletes nothing meaningful for a specific scope — supply at least `module`.

## Related integration

- **Auto-cleanup:** `entity_data_entity_delete()` (`entity_data.module`) calls
  `delete(NULL, $entity->id(), NULL, $entity->getEntityTypeId())` when any entity is deleted.
- **Views:** the `entity_data` table is exposed via `hook_views_data()` (`entity_data.views.inc`) with a
  join per content entity type; the `@ViewsField("entity_data")` handler
  (`src/Plugin/views/field/EntityData.php`) renders a stored value for a row, calling `get()` with the
  configured module/name and running the result through `sanitizeValue()`.

## Usage example

```php
$store = \Drupal::service('entity.data');
$store->set('mymodule', 1, 'send_notifications', 'group', TRUE);
$flag = $store->get('mymodule', 1, 'send_notifications', 'group');
$store->delete('mymodule', 1, 'send_notifications', 'group');
```
