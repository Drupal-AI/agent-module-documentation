# Permissions

## Static (`external_entities.permissions.yml`)

| Permission | Notes |
|---|---|
| `administer external entity types` | `restrict access: true`. Create/edit/delete external entity types and their fields. This is the config-form/admin permission for the `external_entity_type` config entity. |

## Dynamic per-type (`ExternalEntityPermissions::externalEntityTypePermissions`)

For each external entity type (derived id = `{id}`) the callback `buildPermissions()` generates:

| Permission pattern | Grants |
|---|---|
| `view {id} external entity` | View any external entity of this type |
| `view {id} external entity collection` | View the listing |
| `create {id} external entity` | Create a new external entity (write-capable sources only) |
| `update {id} external entity` | Edit any external entity |
| `delete {id} external entity` | Delete any external entity |

The derived content entity type also uses Drupal core's Field-UI permissions
`administer {id} fields`, `administer {id} form display`, `administer {id} display` (checked in
`external_entities_entity_operation()` to expose the Manage fields/display operations), which the
type's `locks` settings can further restrict.

## Set a role permission via Drush

```bash
drush role:perm:add authenticated 'view my_type external entity'
drush role:perm:add content_editor 'administer external entity types'
```

`administer external entity types` is declared with `restrict access: true` in
`external_entities.permissions.yml`, so it is treated as an administrative permission by Drupal core.
