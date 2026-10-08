<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `entity_usage.permissions.yml`.

| Permission | Gates | Restricted |
|---|---|---|
| `access entity usage statistics` | Viewing the usage report (`entity_usage.usage_list`) and the per-entity "Usage" local task. **In addition**, `ListUsageController::checkAccess()` requires `view` access on the target entity itself, so users only see usage for entities they may view. | no |
| `perform batch updates entity usage` | The batch-update form (`entity_usage.batch_update`) that deletes and regenerates all statistics. | **yes** |
| `administer entity usage` | The settings form (`entity_usage.settings.form`). | **yes** |

The usage report additionally hardens display: a source's label is shown as
"- Restricted access -" unless the viewer has `view label` access, and it is linked
only when the viewer has `view` access to that source entity
(`ListUsageController::getSourceEntityLink()`).
