# Node Authorize Link — permissions

Defined in `node_authlink.permissions.yml` plus a dynamic per-bundle callback
(`NodeAuthlinkPermissions::permissions`).

| Permission | `restrict access` | Gates |
|---|---|---|
| `configure node_authlink module` | (not set) | Seeing/using the "Node authorize link" section on the **content-type edit form** (enable, grants, expire, batch generate/delete). This is where authlinks are switched on and where batch key ops live. |
| `create and delete node authlinks` | **TRUE** | Minting/deleting a key for **any** node: the per-node `/node/{node}/authlink` form, the delete confirm form, and the "Delete Authlink" links in the `node_authlinks` view. |
| `create and delete node <bundle> authlinks` | (dynamic; per content type) | Same as above but scoped to one content type. Generated for each node type. |

## Notes for granting
- `create and delete node authlinks` / per-bundle variants control who can **issue** links.
  Whoever holds them can generate a key and thereby hand out anonymous view/edit/delete access to
  a node (per the bundle's configured grants) — treat as a trusted capability (the global one is
  `restrict access: TRUE`).
- `configure node_authlink module` is **not** marked `restrict access` in code, but what it gates
  is editing content-type configuration, which in practice sits alongside `administer content
  types`; it lets a holder enable authlinks and run the bundle-wide batch generate/delete. Grant
  it only to roles you trust with content-type configuration.
- The visitor who *uses* a link needs **no permission** — the authkey itself is the credential;
  access flows through the node access handlers, not a permission check.
- Per-node form access also requires the node's bundle to be authlink-enabled (checked in
  `NodeAuthlinkNodeForm::access()` / `AuthlinkDeleteLink`).
