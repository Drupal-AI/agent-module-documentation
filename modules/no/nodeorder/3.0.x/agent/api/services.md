<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Order services & storage

Three services (`nodeorder.services.yml`). No plugin types, no Drush.

## `nodeorder.manager` → `NodeOrderManager` (implements `NodeOrderManagerInterface`)

The core business logic. Key methods:

- `vocabularyIsOrderable($vid): bool` — TRUE if `nodeorder.settings.vocabularies[$vid]` is truthy.
- `canBeOrdered(NodeInterface $node): bool` — TRUE if the node has an entity_reference→taxonomy_term
  field targeting a vocabulary that exists (result cached per node type, tag `nodeorder`).
- `getOrderableTids(NodeInterface $node, $reset = FALSE): int[]` — the node's term ids that are in
  orderable vocabularies (reads `taxonomy_index` joined to `taxonomy_term_data`; cached).
- `getOrderableTidsFromNode(NodeInterface $node): int[]` — same intent but computed from the node's
  field values (used when rows were already removed from the DB, e.g. on delete).
- `addToList(NodeInterface $node, $tid)` — push a node to the top of a term's ordered list,
  rebalancing weights around zero.
- `handleListsDecrease($tid)` — recompute/rebalance a term's list after a node leaves it.
- `getTermMinMax($tid, $reset = FALSE): ['min'=>int,'max'=>int]` — min/max weight in a term.
- `selectNodes(array $tids, $operator, $depth, $pager, $order, $count)` — legacy taxonomy node
  selector (ported from D7 `taxonomy_select_nodes`).

Positions are kept balanced automatically by the module's node hooks
(`nodeorder_node_insert/update/delete/presave` in `nodeorder.module`), so you rarely call the
mutators directly — new/newly-orderable nodes are pushed to the top; removals rebalance.

## `nodeorder.config_manager` → `ConfigManager` (`ConfigManagerInterface`)

Thin wrapper over `nodeorder.settings` (constants on the interface: `CONFIG_NAME`,
`KEY_VOCABULARIES`, `KEY_ENTITY_LIST_LIMIT`, `KEY_SHOW_LINKS_ON_NODE`, `KEY_OVERRIDE_TAXONOMY_PAGE`,
`KEY_LINK_TO_ORDERING_PAGE`, `KEY_LINK_TO_ORDERING_PAGE_TAXONOMY_ADMIN`):

- `config()` — the editable `nodeorder.settings` config object.
- `updateOrderableValue(string $vid, bool $isOrderable)` — add/remove a vocabulary from the
  `vocabularies` map (keeps the `vid => vid` shape).
- `updateConfigValues(array $data)` — set any of the known keys at once.

## `nodeorder.term_tree_loader` → `TermTreeLoader`

Loads descendant term ids for a vocabulary/term (`descendantTids($vid)`,
`descendantTidsByTermId($tid, $depth)`), used by the orderable/non-orderable switch batch and
`selectNodes`.

## Storage model

- Per-node ordering weight: **`taxonomy_index.weight`** (signed int column added at install). One
  row per (nid, tid); lower weight = higher in the list; lists are balanced around zero.
- Which vocabularies are orderable: `nodeorder.settings.vocabularies` (config).
- There is **no** config entity or field for node order — read/write positions via that column
  (the module does so with the database service), or reorder through the `/taxonomy/term/{tid}/order`
  UI which writes the same column.
