# Permissions

Defined in `entity_usage.permissions.yml`.

| Permission | Gates |
|---|---|
| `access entity usage statistics` | View usage statistics — the per-entity "Usage" tab and the usage report page (`/admin/content/entity-usage/{entity_type}/{entity_id}`, route `entity_usage.usage_list`). The report route additionally requires `view` access to the entity being reported on (`ListUsageController::checkAccess`). |
| `perform batch updates entity usage` | Access the batch-update form (`/admin/config/entity-usage/batch-update`) that resets/rebuilds all usage records. Restricted (trusted) permission. |
| `administer entity usage` | Access the settings form (`/admin/config/entity-usage/settings`). Restricted (trusted) permission. |

Grant via drush:
```
drush role:perm:add content_editor 'access entity usage statistics'
```
