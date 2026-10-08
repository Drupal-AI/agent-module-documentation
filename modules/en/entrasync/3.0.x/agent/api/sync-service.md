<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntraSync service, Graph fetch, queue, managed entities, plugin type, events

Source: `src/Services/EntraSync.php`, `src/Plugin/QueueWorker/EntraUserProcessor.php`,
`src/Plugin/StoragePluginManager.php`, `src/Plugin/StorageInterface.php`, `src/Plugin/StorageBase.php`,
`src/Attribute/EntraSyncStoragePlugin.php`, `src/Annotation/EntraSyncStoragePlugin.php`,
`src/Event/*.php`, `entrasync.api.php`, `entrasync.module`, `entrasync.install`,
`entrasync.services.yml`.

## Service `entrasync.entra_sync` (`Services\EntraSync`)

Central helper. Key methods:

- `getEntraUsersList(SyncEntity)` — builds the Graph client with
  `graphFactory->buildGraphFromKeyId($syncEntity->get('graph_key'))` (factory from ms_graph_api),
  then queries `"/users/delta?$count=true&$select=<props>"` with header `ConsistencyLevel: eventual`.
  Properties come from `graph_properties` plus `id` and `accountEnabled`. If `delta_query` is on and a
  stored delta link exists (State key `entrasync_deltalink_<id>`) it uses that link instead, so only
  new/changed users are returned; the fresh delta link is stored back after paging. Users are paged
  via `createCollectionRequest("GET",…)->setReturnType(User::class)`, then **distilled** to the
  selected properties by calling each `get<Property>()` getter. Dispatches
  `EntraDistilledUsersAlter` and returns the (possibly altered) array. Errors are caught, logged, and
  reported; returns `[]` on failure.
- `reduceUsersFromEntra(SyncEntity, array)` — in-PHP filter over the distilled array using the
  configured property/operator/value (str_contains / str_starts_with / str_ends_with / ===, etc.).
- `processEntraUsers(array, SyncEntity)` — pushes each user onto queue `entrasync_user_processor` as
  `['user' => <distilled>, 'sync_entity_id' => <id>]`.
- `fullSync(SyncEntity)` — `getEntraUsersList()` → optional `reduceUsersFromEntra()` → `processEntraUsers()`.
- Managed-entity bookkeeping against table `entrasync_managed_entities`:
  `recordManagedEntity()`, `updateManagedEntityRecord()` (upsert via `merge()`, logs status
  transitions), `getManagedEntity()`, `removeManagedEntityRecord()`,
  `removeManagedEntityRecordsForSync()`, `removeStateForSync()`.
- Property helpers `getAllEntraProperties()` / `getDefaultEntraProperties()` /
  `getSelectedEntraProperties()`; `loadStoragePlugin()` instantiates a storage plugin and injects the
  SyncEntity. All DB access uses the query builder with bound conditions/fields.

## Queue worker `entrasync_user_processor` (`EntraUserProcessor`, cron time 60)

`processItem($data)` validates the payload, loads the `SyncEntity`, resolves its `storage_plugin`
(default `user`), loads the plugin via the service, and calls `$plugin->processItem($data, $syncEntity)`.
Malformed items and items for a deleted sync are acked (returned) with a log; a missing plugin throws
`SuspendQueueException`; other exceptions bubble so the queue lease is released and retried.

## Storage plugin type `EntraSyncStorage`

Manager `plugin.manager.entrasync_storage` (`StoragePluginManager`, subdir `Plugin/EntraSyncStorage`,
alter hook `entra_entity_settings_info`). Definition via attribute or annotation
`EntraSyncStoragePlugin` (`id`, `label`, `drupal_entity_type`). Contract `StorageInterface`:
`buildForm()`, `submitForm()`, `validateForm()`, `processItem()`, `useGenericEntityMethods()`.

`StorageBase` (abstract, `ContainerFactoryPluginInterface`) provides the generic machinery reused by
both shipped plugins: `getDesiredDrupalEntityFields()` (custom `field_*`, excluding entity_reference/
image/file), `buildGenericMappingForm()` / `getGenericFieldMappingFromFormState()` (Drupal field →
Entra property), `buildGenericRevisionForm()`, `processGenericEntityMapping()` (writes mapped values,
flattening arrays), `processGenericLabelMapping()` / `getEntityTitle()`, `processGenericEntityStatus()`
(disables the Drupal entity when `accountEnabled !== TRUE`, else applies configured status),
`createRevisionIfNeeded()`, and `dispatchEntityPreSave()`. Concrete plugins live in the submodules
(`user` in entrasync_user, `node` in entrasync_node).

## Events (`entrasync.api.php`)

- `entrasync.distilled_users_alter` (`EntraDistilledUsersAlter::NAME`) — after fetch/distill, before
  filter/queue; `getUsers()` / `setUsers()` / `getSyncEntityId()`.
- `entrasync.entity_pre_save` (`EntraEntityPreSave::NAME`) — per entity, just before save;
  `getEntity()`, `getData()` (`user` + `sync_entity_id`), `getSyncEntity()`.

## Hooks (`entrasync.module` / `.install`)

- `hook_cron` — loads all syncs and runs `fullSync()` for each with `retrieve_on_cron`; per-sync
  try/catch so one failure does not abort the others.
- `hook_requirements` (runtime) — flags syncs whose `graph_key` or `storage_plugin` no longer exists.
- `hook_schema` — table `entrasync_managed_entities` (PK `entra_user_guid` + `entrasync_id`, plus
  `drupal_entity_id`, `is_enabled`, `updated`).
- `hook_uninstall` — sweeps orphaned `entrasync_deltalink_*` State keys.
