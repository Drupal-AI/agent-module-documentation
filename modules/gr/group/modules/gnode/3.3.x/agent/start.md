# gnode (Group Node) — agent start

Submodule of **group**. Relates core **nodes** to groups via the `group_node` GroupRelationType
plugin (one derived `group_node:{node_type}` per node type). Requires core `node` and `group`.
No config UI of its own — you install its plugins through the parent Group type's **content**
page (`/admin/group/types/manage/{group_type}/content`).

- Install & relate nodes to groups (the `group_node` plugin) → [plugins/gnode.md](plugins/gnode.md)
- Per-group node overview access → [permissions/gnode.md](permissions/gnode.md)
- Where installation lives (parent Group content UI) → [configure/gnode.md](configure/gnode.md)

See the parent module: [../../../../3.3.x/agent/start.md](../../../../3.3.x/agent/start.md).
