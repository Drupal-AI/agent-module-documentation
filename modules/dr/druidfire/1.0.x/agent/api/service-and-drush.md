<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services and Drush commands

## Install & enable

```bash
composer require drupal/druidfire
drush en druidfire -y
drush druidfire:list-spells   # or: drush druidfire:ls
```

Core-only; `druidfire.info.yml` declares no `dependencies` and the project ships no `composer.json`.
No admin UI, config form, permissions, routes, `.module`/`.install`, or config schema. Everything is
CLI/PHP. **Back up the database before running any transformation** — spells can drop columns/data.

## Services (`druidfire.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `druidfire` | `Drupal\druidfire\Druidfire` | Facade; `__call()` runs a spell (see below). Args: `@keyvalue`, `@messenger`, `@druidfire.field_inspector`, `@druidfire.config_manager`, `@plugin.manager.druidfire_spell`. |
| `druidfire.field_inspector` | `FieldInspector` | Resolves the DB column for a field. Args: `@entity_type.manager`, `@entity_field.manager`. |
| `druidfire.config_manager` | `ConfigManager` | Rewrites field/display config records. Args: `@config.storage`, `@plugin.manager.field.field_type`, `@entity.last_installed_schema.repository`, `@messenger`. |
| `plugin.manager.druidfire_spell` | `SpellManager` | The Spell plugin manager (see [spell-type.md](../plugins/spell-type.md)). |

### `Druidfire` (facade)

Has only `__call($spellName, $arguments)` and `getAvailableSpells()`. Calling any spell id as a
method (`$s->resize(...)`) runs the full pipeline: resolve column → read schema from the
`entity.storage_schema.sql` keyvalue store → `spell->schema()` per table → write schema back →
`ConfigManager::changeConfig()` for `storage` then `field` → clear cached definitions. Full step
list in [spell-type.md](../plugins/spell-type.md).

### `FieldInspector`

- `getColumnName($entityTypeId, $fieldName, ?$propertyName): string` — gets the entity storage,
  asserts `SqlEntityStorageInterface`, and via `DefaultTableMapping::getFieldColumnName()` returns
  the DB column for the field's main property (or the given `$propertyName`). **Throws
  `InvalidArgumentException('Can only change default SQL fields.')`** if the field is unknown or not a
  default-SQL-storage field. This is why spells only work on SQL-backed content-entity fields.
- `clearCachedDefinitions()` — `entityTypeManager->clearCachedDefinitions()`.

### `ConfigManager`

- `changeConfig($entityTypeId, $fieldName, SpellInterface $spell, $configType, $optionalArguments)` —
  builds callable `[$spell, $configType]`, lists config `field.$configType.$entityTypeId.*` filtered
  to names ending in `.$fieldName`, and applies it via `doChangeConfig()`. When `$configType` is
  `'field'`, it also prepends `$fieldName` to the args and runs the spell's `formDisplay` over
  `core.entity_form_display.$entityTypeId.*` and `viewDisplay` over
  `core.entity_view_display.$entityTypeId.*` (matched by the bundle segment of the field config name).
- `doChangeConfig()` reads each config record, calls the spell method to transform it, and writes it
  back with `configStorage->write()`. For `field.storage.*` records it also refreshes the entity's
  last-installed field-storage definition: gets the new field-type plugin class, runs
  `storageSettingsFromConfigData()`, and calls
  `entityLastInstalledSchemaRepository->setLastInstalledFieldStorageDefinition(new FieldStorageConfig($record))`
  so Drupal's schema state stays consistent.

## Drush commands (`drush.services.yml` → `Commands/DruidfireCommands.php`)

Service `druidfire.command` (tag `drush.command`), constructed with `@druidfire`. Each command is a
thin wrapper that calls the matching service method:

| Command (aliases) | Signature | Calls |
|---|---|---|
| `druidfire:resize` | `<entityTypeId> <fieldName> <size> [property]` | `->resize($t,$f,['size'=>$size,'property'=>$property])` |
| `druidfire:string2formatted` | `<entityTypeId> <fieldName>` | `->string2formatted($t,$f)` |
| `druidfire:err2er` | `<entityTypeId> <fieldName>` | `->err2er($t,$f)` |
| `druidfire:err2bricks` | `<entityTypeId> <fieldName>` | `->err2bricks($t,$f)` |
| `druidfire:string2taxonomyreference` | `<entityTypeId> <fieldName> <vid>` | `->string2taxonomyReference($t,$f,['vid'=>$vid])` |
| `druidfire:list-spells` (`druidfire:ls`) | — | `->getAvailableSpells()`; renders a `Command / Name / Description` box table sorted by command name. |

Examples: `drush druidfire:resize node body 255` · `drush druidfire:resize paragraph link 1024 title`
· `drush druidfire:string2formatted node body` · `drush druidfire:err2er node field_ref` ·
`drush druidfire:err2bricks node field_para` ·
`drush druidfire:string2taxonomyreference node category tags`.

## From PHP (update/deploy hooks)

```php
\Drupal::service('druidfire')->resize('paragraph', 'section_title', ['size' => 1024]);
\Drupal::service('druidfire')->resize('paragraph', 'link', ['size' => 1024, 'property' => 'title']);
\Drupal::service('druidfire')->string2formatted('node', 'body');
\Drupal::service('druidfire')->err2er('node', 'my_field');
\Drupal::service('druidfire')->err2bricks('node', 'my_paragraphs_field');
\Drupal::service('druidfire')->string2taxonomyReference('node', 'category', ['vid' => 'tags']);
```

Progress and per-config messages go through the `messenger` service; schema-step failures are caught
and reported as warnings rather than aborting the run.
