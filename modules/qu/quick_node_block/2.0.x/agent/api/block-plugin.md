<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `quick_node_block` block plugin

Class `Drupal\quick_node_block\Plugin\Block\QuickNodeBlock` (annotation `@Block`), id
`quick_node_block`, admin label / category "Quick Node Block". Implements
`ContainerFactoryPluginInterface`; injects `current_route_match`, `entity_type.manager`,
`entity_display.repository`.

## Form (`blockForm`)

- `quick_node` — `entity_autocomplete`, `#target_type => 'node'`, required, with an AJAX
  `change` handler (`ajaxCallback`) that repopulates the Display options for the picked node's
  bundle. When reached from `admin/node/{node}/quick_node_block`, the node param pre-fills and
  disables the field.
- `quick_display` — `select` of view modes. With no node chosen yet it lists **all** node view
  modes (`getViewModeOptions('node')`); once a node is chosen it lists that content type's view
  modes (`getViewModeOptionsByBundle('node', $type)`); hidden via `#states` until a node is set.

## Save (`blockSubmit`)

Loads the selected node and stores `configuration['quick_node'] =
EntityAutocomplete::getEntityLabels([$node])` (the `Title (nid)` string) and
`configuration['quick_display']` = the chosen view mode.

## Render (`build`)

Parses the nid out of `quick_node` with `preg_match("/.+\s\(([^\)]+)\)/", …)`, loads the node,
and returns `entityTypeManager->getViewBuilder('node')->view($node, $view_mode)`. Empty array
if the pattern doesn't match or the node can't be loaded.

## Access & cache

- `blockAccess($account)` → `getNode()->access('view', $account, TRUE)`; `AccessResult::forbidden()`
  when no node. So the block never renders a node the user can't view.
- `getCacheTags()` merges a `node:<nid>` tag onto the default block cache tags.

## Controller for the node task

`Drupal\quick_node_block\Controller\AddNodeBlock::blockAddConfigureForm()` creates a transient
`block` entity for plugin `quick_node_block` in the current theme and returns its entity form —
this is what the **Add to Block** local task renders.
