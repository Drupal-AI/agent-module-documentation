# The `salesforce_mapping` config entity

One map ties a Drupal entity type/bundle to a Salesforce object type.

## Key fields

| Key | Meaning |
|---|---|
| `id`, `label`, `weight` | machine name, label, order |
| `type` | mapping plugin type (usually `salesforce_mapping`) |
| `drupal_entity_type` / `drupal_bundle` | the Drupal side (e.g. `user` / `user`) |
| `salesforce_object_type` | the Salesforce object (e.g. `Contact`) |
| `key` | Salesforce field used as the upsert key |
| `sync_triggers` | booleans: `push_create`, `push_update`, `push_delete`, `pull_create`, `pull_update`, `pull_delete` |
| `field_mappings` | array of SalesforceMappingField plugin instances (see `plugins/field-plugins.md`) |
| `async` | push via queue instead of synchronously |
| `always_upsert` | upsert instead of create/update |
| `push_standalone` / `pull_standalone` | process this map's queue via standalone endpoint |
| `push_limit`, `push_retries`, `push_frequency`, `pull_frequency` | queue tuning |
| `pull_where_clause`, `pull_trigger_date`, `pull_record_type_filter` | pull scoping |

## Create a mapping in code

```php
$mapping = \Drupal::entityTypeManager()->getStorage('salesforce_mapping')->create([
  'id' => 'user_contact',
  'label' => 'User → Contact',
  'weight' => 0,
  'type' => 'salesforce_mapping',
  'key' => 'Email__c',
  'async' => TRUE,
  'always_upsert' => FALSE,
  'salesforce_object_type' => 'Contact',
  'drupal_entity_type' => 'user',
  'drupal_bundle' => 'user',
  'sync_triggers' => [
    'push_create' => TRUE, 'push_update' => TRUE, 'push_delete' => FALSE,
    'pull_create' => FALSE, 'pull_update' => FALSE, 'pull_delete' => FALSE,
  ],
  'field_mappings' => [],
]);
$mapping->save();
```

Read it back:
```bash
drush cget salesforce.mapping.user_contact          # config name is salesforce.mapping.<id>
# or in PHP: $m->getSalesforceObjectType(), $m->get('sync_triggers')
```

## Mapped objects

`salesforce_mapped_object` (content entity) links a specific Drupal entity to its Salesforce
record (SFID) and is created/updated by push/pull. Revisions are capped by
`salesforce.settings.limit_mapped_object_revisions`. Permission
`administer salesforce mapped objects` gates managing them.

## Permissions

- `administer salesforce mapping` — create/edit/delete mappings.
- `view salesforce mapping` — view mapping config.
- `administer salesforce mapped objects` — manage mapped-object records.

## Notes

- Mapping does no network I/O; enable `salesforce_push` and/or `salesforce_pull` and set the
  matching `sync_triggers` to actually move data.
- Build maps in the UI via `salesforce_mapping_ui` (route `entity.salesforce_mapping.list`).
