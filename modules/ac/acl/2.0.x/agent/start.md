<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ACL — agent index

A **node-access API** for other modules: build per-user access lists and grant them
view/update/delete on individual nodes. **No UI, no config, no permissions, no Drush, no
services** — it is a set of procedural `acl_*` functions plus core node-access hooks, backed
by three DB tables. Registers node-access realm **`acl`**. Enabling it forces a permissions
rebuild.

- **The `acl_*` API functions, the 3 tables, and the node-access hooks** →
  [api/functions.md](api/functions.md)
- **Hooks a *client* module must/can implement (`hook_enabled`, `hook_acl_explain`)** →
  [hooks/client-hooks.md](hooks/client-hooks.md)

Key facts:
- Tables: **`acl`** (`acl_id`, `module`, `name`, `figure`), **`acl_user`** (`acl_id`, `uid`),
  **`acl_node`** (`acl_id`, `nid`, `grant_view`, `grant_update`, `grant_delete`, `priority`).
- Typical flow: `acl_create_acl($module,$name,$figure)` → `acl_add_user($acl_id,$uid)` →
  `acl_node_add_acl($nid,$acl_id,$view,$update,$delete,$priority)`.
- A client module **must** implement `hook_enabled()` returning TRUE or ACL suppresses its
  grants; a list with **no users** produces a *deny* grant, not access.
- Also ships D6/D7 migrate source/destination plugins (`src/Plugin/migrate/`) for legacy upgrades.
