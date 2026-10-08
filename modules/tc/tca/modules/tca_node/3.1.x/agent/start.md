# TCA nodes (tca_node) — agent index

Adds TCA support for the **node** entity type. Enable it (plus parent `tca`) to token-gate
node viewing. No config page, no own permissions/schema. See the parent for how TCA works:
[../../../../3.1.x/agent/start.md](../../../../3.1.x/agent/start.md).

Key facts:
- Registers `TcaPlugin` id `tca_node`, `entityType: node`, `isFieldable() = TRUE`
  (`modules/tca_node/src/Plugin/TcaPlugin/Node.php`) → installs `tca_active`/`tca_public`/
  `tca_token` base fields on nodes.
- Generates the concrete permissions `tca administer node` and `tca bypass node` (via the
  parent's permission generator).
- `tca_node.module` hides protected nodes from **core search**
  (`hook_query_search_node_search_alter`) and **Views**
  (`hook_views_query_alter`) for users without `tca bypass node`: adds an OR filter keeping
  only `tca_active IS NULL/0` or bundles with TCA disabled.
- No config of its own.
