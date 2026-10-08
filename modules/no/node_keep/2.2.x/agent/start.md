# Node Keep — agent index

Adds boolean base fields to nodes that block deletion (`node_keeper`) and — when Pathauto is
installed — alias changes (`alias_keeper`) for users lacking the `administer node_keep per node`
permission. One global setting; per-content-type defaults; enforced via `hook_node_access()`.

- **The base fields, per-node use, per-content-type defaults, the settings form** →
  [configure/protect-nodes.md](configure/protect-nodes.md)
- **How deletion/alias protection is enforced (hook_node_access, form alter)** →
  [api/enforcement.md](api/enforcement.md)
- **The three permissions and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Base fields on every node: `node_keeper` (boolean) and, with Pathauto, `alias_keeper` (boolean).
- Config form: `node_keep.settings` → `/admin/config/content/node-keep`; only key: `hide_warning_messages` (bool).
- Per-type defaults stored as `node.type.<bundle>` third-party settings under `node_keep`
  (`node_keeper`, `alias_keeper`) plus a base-field-override default value.
- Submodule `node_keep_token` (nested) exposes protected nodes as tokens.
