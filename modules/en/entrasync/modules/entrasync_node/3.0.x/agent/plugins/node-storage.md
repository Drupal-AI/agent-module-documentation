<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NodeStorage plugin (`node`)

Source: `modules/entrasync_node/src/Plugin/EntraSyncStorage/NodeStorage.php` (extends
`Drupal\entrasync\Plugin\StorageBase`). Enabled by the `entrasync_node` submodule. Uses core
`Drupal\node\Entity\Node`.

Plugin definition: `@EntraSyncStoragePlugin(id="node", label="Node", drupal_entity_type="node")`.
`useGenericEntityMethods()` returns TRUE, so it reuses the base generic field/label/status/revision
helpers. It uses the base constructor/services (no extra injection).

## Config sub-form (`buildForm()`)

Rendered inside the EntraSync add/edit form under a "Drupal node configuration" details element:

- **Node title mapping** (`generic_entity_label_mapping`, required) — Entra property used as the node
  title (default `mail`).
- **Field mapping** — base `buildGenericMappingForm()` over the custom `field_*` fields of the
  selected bundle. The bundle comes from the base form's bundle selector (`generic_bundle`), defaulting
  to the first node bundle.
- **State of node** (`generic_entity_status`, required) — Published (1) / Unpublished (0), default 0.
- **Create new revision when synced data changes** (`generic_entity_create_revision`) — via
  `buildGenericRevisionForm()`.

`submitForm()` simply delegates to `StorageBase::submitForm()`.

## Create / update (`processItem(array $data, SyncEntity)`)

Runs from the base `entrasync_user_processor` queue worker per user:

1. `entra_enabled = ($data['user']['accountEnabled'] === TRUE)`. If the Entra account is disabled and
   there is no managed record for it, the item is skipped.
2. Resolve the managed record with `EntraSync::getManagedEntity()`. If managed, `Node::load()` the
   stored node id (skipped with a warning if it was deleted in Drupal). If not managed and the account
   is enabled, `Node::create(['type' => generic_bundle, 'title' => getEntityTitle()])`. Otherwise return.
3. Snapshot `$node->toArray()` as `$original`, then apply mapped fields
   (`processGenericEntityMapping()`), title (`processGenericLabelMapping()`) and status
   (`processGenericEntityStatus()` — unpublishes when the Entra account is disabled, else the
   configured default).
4. `dispatchEntityPreSave()` (event `EntraEntityPreSave`), then `createRevisionIfNeeded()` — a new
   revision is created only if the entity is not new, `generic_entity_create_revision` is on, the type
   is revisionable, and `$original !== $node->toArray()`.
5. `save()`, then `EntraSync::updateManagedEntityRecord()` to upsert the Entra-GUID ↔ node-id mapping.
   Exceptions are logged and rethrown so the queue can retry.

Node field/title values come from the mapped Entra properties; state and bundle come from the sync
configuration.
