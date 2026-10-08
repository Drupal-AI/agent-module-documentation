<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `taxonomy_term_title_length.taxonomy_term` service & settings

## What it is

`Drupal\taxonomy_term_title_length\TaxonomyTermTitleLength` — a concrete subclass of the
parent's abstract `Drupal\title_length\EntityTitleLength`. It fixes the three abstract methods:

| Method | Value |
|---|---|
| `getEntityType()` | `'taxonomy_term'` |
| `getNameOfTitleField()` | `'name'` |
| `getBaseFieldDefinitions($etype)` | `Term::baseFieldDefinitions($etype)` |

Registered as service **`taxonomy_term_title_length.taxonomy_term`** (args `@database`,
`@entity_type.manager`, `@entity.definition_update_manager`). Inherits `getLength()`,
`changeLength()`, `checkIfExistEntitiesWithLongTitles()` from the parent — see
[../../../../../2.1.x/agent/api/service.md](../../../../../2.1.x/agent/api/service.md).

## Choosing the length

`getLength()` returns `Settings::get('taxonomy_term_title_length_chars') ?: 500`. To use
something other than 500:

```php
// settings.php
$settings['taxonomy_term_title_length_chars'] = 1000;
```

Then re-apply: `drush title_length:update taxonomy_term`.

## Install / uninstall behavior

- **Install** (`taxonomy_term_title_length_install()`): calls
  `\Drupal::service('taxonomy_term_title_length.taxonomy_term')->changeLength(TaxonomyTermTitleLength::getLength())`,
  widening the term `name` column(s) to the length and re-installing the `name` base-field storage
  definition.
- **Runtime**: `taxonomy_term_title_length_entity_base_field_info_alter()` sets
  `$fields['name']->setSetting('max_length', TaxonomyTermTitleLength::getLength())` for the
  `taxonomy_term` entity type, so the form/validation limit tracks the column.
- **Uninstall** (`taxonomy_term_title_length_uninstall()`): shrinks the column back to
  `ORIGINAL_LENGTH` (255), but first calls `checkIfExistEntitiesWithLongTitles()` and throws
  `ModuleUninstallValidatorException` if any term/revision name is longer than 255 (shorten or
  delete those first).

## Call it directly

```php
$svc = \Drupal::service('taxonomy_term_title_length.taxonomy_term');
$svc->changeLength(\Drupal\taxonomy_term_title_length\TaxonomyTermTitleLength::getLength());
```

## Verifying the live column width

The base-field `max_length` reported by the entity field manager always equals `getLength()`
(from the runtime hook), so it is not proof of the real column. Check the schema instead — the
term data table is usually `taxonomy_term_field_data`:

```sql
SELECT CHARACTER_MAXIMUM_LENGTH FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'taxonomy_term_field_data' AND COLUMN_NAME = 'name';
```
