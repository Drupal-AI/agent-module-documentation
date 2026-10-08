<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# adva access model (storage, handler, query alter)

## Grant table `adva_access` (`adva.install`)
Mirrors core `node_access`: `entity_type`, `entity_id`, `langcode`, `fallback`, `gid`, `realm`,
`grant_view`, `grant_update`, `grant_delete`. A **default grant** row per entity type
(`entity_id=0`, `realm='all'`, `gid=0`, all grant bits = 1) is inserted by
`AccessStorage::saveDefaultGrant()` (called from `clearRecords`) — this is the "public" fallback,
same idea as core node access.

## Record writing (`AccessStorage::saveRecords`)
On entity insert/update the consumer's provider records are written; **only rows with at least
one grant bit set are inserted** ("denies are implicit"). An entity all of whose provider records
are pure denies therefore gets **no** row of its own.

## Entity-level access (`AdvancedAccessEntityAccessControlHandler` + `AccessStorage::access`)
For **overriding** consumers (e.g. media), the handler computes:
```
result = (legacyHandler ?? core)->access(op)            // AccessResult
if (!result->isForbidden())
    result = result->orIf(accessStorage->access(entity, op, account))
```
`AccessStorage::access()` returns `allowed` or `neutral` (never forbidden):
- With both bypass perms → allowed.
- No providers configured → `view` = allowed (public), else neutral.
- Otherwise queries `adva_access`: allowed if a row matches the user's grants for this entity,
  **or** `defaultCondition()` matches — i.e. the entity has **no** specific row and the
  `entity_id=0` default (public) row exists.

## Listing filter (`adva_query_alter` → `AccessStorage::alterQuery`)
Queries tagged `<entity_type>_access` (Views, EntityQuery with access check) are joined to a
subquery over `adva_access` restricted to the user's grants. **If the user has no matching
grants, the subquery is forced `WHERE FALSE`** → those entities are removed from results.
Bypassed for holders of `bypass adva access` / `bypass adva <type> access`.

## Other services / integration
- `AccessStorage` (`adva.access_storage`, `backend_overridable`): `access`, `alterQuery`,
  `updateRecordsFor`/`deleteRecordsFor`, `checkAll`, `count`, `saveDefaultGrant`.
- `adva.parm_parser` param converter resolves `{consumer}` route params to consumer plugins.
- `Plugin/search_api/processor/AdvancedAccess` applies grants to Search API indexes.
- Queue worker `RebuildAccessRecordsQueueWorker` (queue base `adva_rebuild_access_records`)
  and batch `adva.batch.consumer_access_rebuild` rebuild records after config changes.
