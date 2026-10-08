<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `entity_usage.permissions.yml`.

| Permission | Gates |
|---|---|
| `access entity usage statistics` | View usage statistics — the per-entity "Usage" tab and the usage report page (`/admin/content/entity-usage/{entity_type}/{entity_id}`, route `entity_usage.usage_list`). Both the report route and the per-entity local-task route additionally require `view` access to the entity being reported on (`ListUsageController::checkAccess` / `LocalTaskUsageController::checkAccessLocalTask`). |
| `perform batch updates entity usage` | Access the batch-update form (`/admin/config/entity-usage/batch-update`) that resets/rebuilds all usage records. `restrict access: TRUE` (trusted). |
| `administer entity usage` | Access the settings form (`/admin/config/entity-usage/settings`). `restrict access: TRUE` (trusted). |

Grant via drush:
```
drush role:perm:add content_editor 'access entity usage statistics'
```

Note: within the usage report each listed source entity is access-checked individually — its
label and link are only shown to a viewer with `view label` / `view` access on that source, so
`access entity usage statistics` alone does not expose the labels or URLs of entities the
viewer cannot see.

The per-entity "Usage" tab / report (`entity_usage.usage_list`) lists each source, its type,
language, field and publish status:

![Entity Usage report](../../../../../../../screenshots/entity_usage/2.3.x/usage-report.png)
