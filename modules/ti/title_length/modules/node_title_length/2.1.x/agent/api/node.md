# `node_title_length.node` service & settings

## What it is

`Drupal\node_title_length\NodeTitleLength` — a concrete subclass of the parent's abstract
`Drupal\title_length\EntityTitleLength`. It fixes the three abstract methods:

| Method | Value |
|---|---|
| `getEntityType()` | `'node'` |
| `getNameOfTitleField()` | `'title'` |
| `getBaseFieldDefinitions($etype)` | `Node::baseFieldDefinitions($etype)` |

Registered as service **`node_title_length.node`** (args `@database`,
`@entity_type.manager`, `@entity.definition_update_manager`). Inherits `getLength()`,
`changeLength()`, `checkIfExistEntitiesWithLongTitles()` from the parent — see
[../../../../2.1.x/agent/api/service.md](../../../../2.1.x/agent/api/service.md).

## Choosing the length

`getLength()` returns `Settings::get('node_title_length_chars') ?: 500`. To use something
other than 500:

```php
// settings.php
$settings['node_title_length_chars'] = 1000;
```

Then re-apply: `drush title_length:update node`.

## Install / uninstall behavior

- **Install** (`node_title_length_install()`): calls
  `\Drupal::service('node_title_length.node')->changeLength(NodeTitleLength::getLength())`,
  widening `node_field_data.title` and `node_field_revision.title` to the length and
  re-installing the `title` base-field storage definition.
- **Runtime**: `node_title_length_entity_base_field_info_alter()` sets
  `$fields['title']->setSetting('max_length', NodeTitleLength::getLength())` for the `node`
  entity type, so the form/validation limit tracks the column.
- **Uninstall** (`node_title_length_uninstall()`): shrinks the column back to
  `ORIGINAL_LENGTH` (255), but first calls `checkIfExistEntitiesWithLongTitles()` and throws
  `ModuleUninstallValidatorException` if any node/revision title is longer than 255 (shorten
  or delete those first).

## Call it directly

```php
$svc = \Drupal::service('node_title_length.node');
$svc->changeLength(\Drupal\node_title_length\NodeTitleLength::getLength()); // re-apply (500 or settings value)
```

## Verifying the live column width

The base-field `max_length` reported by the entity field manager always equals `getLength()`
(from the runtime hook), so it is not proof of the real column. Check the schema instead:

```sql
SELECT CHARACTER_MAXIMUM_LENGTH FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'node_field_data' AND COLUMN_NAME = 'title';
```
