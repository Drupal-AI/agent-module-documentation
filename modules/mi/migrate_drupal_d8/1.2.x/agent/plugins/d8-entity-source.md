# The `d8_entity` migrate source plugin

`migrate_drupal_d8` defines migrate **source** plugins only (it does not define a plugin *type* —
it plugs into core `migrate`'s `plugin.manager.migrate.source`). The one plugin you should use is
`d8_entity`.

## Plugin

- **id:** `d8_entity`
- **class:** `Drupal\migrate_drupal_d8\Plugin\migrate\source\d8\ContentEntity` (extends
  `Drupal\migrate\Plugin\migrate\source\SqlBase`)
- **What it does:** queries a *source* Drupal 8+ database for one content-entity type, and in
  `prepareRow()` attaches every non-deleted Field API field value (from the source's dedicated field
  tables) plus multi-value base fields as source properties.

## Configuration keys

| Key | Required | Meaning |
|---|---|---|
| `plugin` | yes | Always `d8_entity`. |
| `key` | yes | The source **database connection key** from `settings.php` (first index of `$databases`). |
| `entity_type` | yes | Source entity type id, e.g. `node`, `user`, `taxonomy_term`, `file`, or any custom content entity. Missing → `InvalidPluginDefinitionException`. |
| `bundle` | no | Restrict to one bundle. Omit to read all bundles of the type. |

## Source database connection (settings.php / settings.local.php)

```php
$databases['d8_source_site']['default'] = [
  'driver'   => 'mysql',
  'database' => 'd8_source_site',
  'username' => 'drupal_db_user',
  'password' => 'drupal_db_password',
  'host'     => '127.0.0.1',
  'port'     => 3306,
];
```

Here `key: d8_source_site` and (implicitly) target `default`.

## Migration YAML example

```yaml
# e.g. a migrate_plus migration config entity, or a module's migrations/*.yml
source:
  plugin: d8_entity
  key: d8_source_site
  entity_type: node
  bundle: article
process:
  title: title
  # Sub-fields need a delta index even for single-value fields:
  'body/value': 'body/0/value'
  'body/summary': 'body/0/summary'
  'body/format': 'body/0/format'
destination:
  plugin: 'entity:node'
  default_bundle: article
```

- Plain (no sub-field) properties map directly: `title: title`.
- Fields with columns (`body`, address, link, etc.) are addressed as `field/<delta>/<column>`.
- `getIds()` returns the entity id key (and langcode for translatable types), so migrations track
  and can roll back rows.

## Deprecated aliases (do not use in new migrations)

Each just presets `entity_type` and extends `d8_entity`; all emit `E_USER_DEPRECATED`:

| id | Equivalent |
|---|---|
| `d8_node` | `d8_entity` + `entity_type: node` |
| `d8_user` | `d8_entity` + `entity_type: user` |
| `d8_file` | `d8_entity` + `entity_type: file` |
| `d8_taxonomy_term` | `d8_entity` + `entity_type: taxonomy_term` |

## Notes / limits

- Reads are direct SQL against the **source** DB; the source site is not modified.
- Field definitions come from the source `config` table (`field.field.*`, `field.storage.*`); deleted
  fields (status = false) are skipped.
- Long field table names (> 48 chars) are resolved via the same SHA-256-hash scheme core uses
  (`getDedicatedDataTableName()`), reading the field storage `uuid` from source config.
- `@todo`s in the code note multilingual field values are not fully handled.
