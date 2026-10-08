<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntraSync Node Storage (entrasync_node) — agent index

Submodule of **entrasync**. Provides the `node` **EntraSyncStorage** plugin: turns each distilled
Microsoft Entra user into a **Drupal node** of a chosen content type (e.g. a staff directory).
Package `Custom`. Version **3.0.0-beta2** (pre-release). Core `^10 || ^11`. License GPL-2.0-or-later.

- **The node storage plugin: form fields, create/update logic, revisions** →
  [plugins/node-storage.md](plugins/node-storage.md)

## Dependencies

- Requires `entrasync` (`drupal:entrasync`) for the plugin type, sync service, queue worker and Graph
  fetch. Uses core **Node** (`Drupal\node\Entity\Node`). No config schema, permissions, or Drush of
  its own.

## What it provides

- One plugin: `NodeStorage` (id **`node`**, label *Node*, `drupal_entity_type = "node"`) in
  `modules/entrasync_node/src/Plugin/EntraSyncStorage/NodeStorage.php`, extending
  `Drupal\entrasync\Plugin\StorageBase`.
- Adds the plugin sub-form: node title mapping, generic field mapping, published/unpublished state,
  and the "create new revision" checkbox. Target bundle is chosen with the base form's bundle selector
  (`generic_bundle`).
- `processItem()` runs from the base module's `entrasync_user_processor` queue worker to create or
  update the node.

No routes, permissions, hooks or services beyond the plugin.
