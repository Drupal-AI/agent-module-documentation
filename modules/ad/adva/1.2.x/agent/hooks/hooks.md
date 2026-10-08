<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# adva hooks

adva has no `adva.api.php`; the relevant hooks are the core hooks it **implements** to wire the
grant system. Knowing them helps when debugging why records/access change.

Implemented by `adva.module`:
- `hook_entity_type_build()` — for each **overriding** consumer, swaps the entity type's access
  handler to `AdvancedAccessEntityAccessControlHandler`.
- `hook_entity_insert()` / `hook_entity_update()` — recompute + save `adva_access` records for
  the entity (overriding consumers only) via `AccessStorage::updateRecordsFor`.
- `hook_entity_delete()` — delete the entity's records.
- `hook_query_alter()` — for queries tagged `<entity_type>_access`, join `adva_access` to filter
  results to the account's grants (see api/access-model.md). Reads query metadata `op`
  (view/update/delete), `account`, `base_table`, `langcode`, `view`. Skips accounts with a bypass
  permission. Non-base-table access queries must add `->addMetaData('base_table', '<table>')`.
- `hook_requirements()` (`adva.install`) — status-report entry per entity type with grant count
  and a "Rebuild Required" warning when the rebuild queue is non-empty.

Node bridge (submodule `adva_na`, `adva_na.module`):
- `hook_node_access_records($node)` → consumer's `getAccessRecords($node)`.
- `hook_node_grants($account, $op)` → consumer's `getAccessGrants($op, $account)`.
These route node access through core's own node-grant system rather than adva's overriding
handler.

To extend behavior, implement the manager alter hooks: `hook_advanced_access_consummer_alter`
(consumer plugin info) and `hook_adva_provider_alter` (provider plugin info). To add access
logic, write a Provider/Consumer plugin — see plugins/access-plugins.md.
