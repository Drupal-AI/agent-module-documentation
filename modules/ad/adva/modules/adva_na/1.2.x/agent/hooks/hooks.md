<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# adva_na — node-grant bridge

`adva_na.module` implements core's node access hooks, delegating to the `node` Access Consumer
(`\Drupal::service('plugin.manager.adva.consumer')->getConsumerForEntityTypeId('node')`):

- **`hook_node_access_records(NodeInterface $node)`** → `$consumer->getAccessRecords($node)`.
  Returns the realm/gid + grant_view/update/delete rows (aggregated from enabled providers) that
  core writes to its `node_access` table for this node.
- **`hook_node_grants(AccountInterface $account, $op)`** → `$consumer->getAccessGrants($op, $account)`.
  Returns `['<realm>' => [<gid>, ...]]` the account holds for the operation; core intersects these
  with each node's records to decide access.

Consumer: `NodeAccessConsumer` (`src/Plugin/adva/AccessConsumer/NodeAccessConsumer.php`, id
`node`, extends the basic `AccessConsumer`). Its only override is `onChange()`, which after the
parent call runs `node_access_needs_rebuild(TRUE)` so the admin is prompted to rebuild node
permissions after changing provider config.

Because access is enforced by **core's** node grant system (both the `node_access` query tag on
listings and `$node->access()`), enforcement is consistent and fails closed — there is no
overriding access handler here. Rebuild node permissions after config changes via the status
report link or `drush php:eval 'node_access_rebuild();'`.
