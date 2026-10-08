<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nodeaccess grants view / edit / delete access to nodes on a per-content-type and per-node basis, letting you assign those grants to individual roles, individual users, and the node's author through Drupal's node grant system.

---

The module implements Drupal's node access grant hooks. `hook_node_grants()` issues each account grant IDs in three realms — `nodeaccess_role` (from the account's roles), `nodeaccess_user` (the user's own ID), and `nodeaccess_author` (for authenticated authors). `hook_node_access_records()` writes the grants for each node: if the node has per-node grants set via its **Grants** tab (stored in the module's own `nodeaccess` database table) those win; otherwise it falls back to the content-type defaults stored in the `nodeaccess.settings` config object under `bundles_roles_grants[<bundle>][<role>|author]`. A global settings form (`/admin/config/people/nodeaccess`, route `nodeaccess.administration`) controls, per content type, which roles are selectable on the Grants tab, whether the Grants tab is available for that bundle, and which grant operations (view/update/delete) are offered. Config keys include `bundles_roles_grants`, `grants_tab_availability`, `map_rid_gid` (role→numeric grant-ID map), `roles_settings`, and `allowed_grant_operations`. The per-node **Grants** tab (`/node/{node}/grants`, route `entity.node.grants`) lets a privileged user grant view/edit/delete to selected roles and to searched-for users for that one node. Permissions include `administer nodeaccess`, `grant node permissions`, and a dynamically generated per-content-type `nodeaccess grant <type> permissions`. Changing grants flags node access for rebuild.

---

- Give a specific role view-but-not-edit access to all nodes of a content type by default.
- Let content authors edit and delete only their own nodes via the author grant.
- Grant a single editor edit access to one particular node through its Grants tab.
- Allow a "reviewer" role to view unpublished-style restricted content of one type.
- Share a private node with a handful of named users without changing site-wide permissions.
- Set per-content-type defaults so every new Article is viewable by an "editors" role.
- Expose the Grants tab only on the content types where per-node control is needed.
- Restrict which roles appear as options on the Grants tab to keep it manageable.
- Offer only view/edit (not delete) grant checkboxes on the Grants tab via allowed operations.
- Delegate per-node grant management to non-admins with the per-type grant permission.
- Build a workflow where an author keeps edit rights while a role gets view rights.
- Give a department role delete rights to its own content type's nodes.
- Grant one user delete access to a specific outdated node for cleanup.
- Enforce that anonymous users only see nodes explicitly granted view.
- Combine role-based defaults with per-node overrides for exceptions.
- Provide translation-aware grants (grants are written per translation language).
- Rebuild node access permissions after adjusting the grant configuration.
- Model a members-only section by granting view to an authenticated-members role per type.
- Let a client-user edit only the pages you explicitly grant them on a per-node basis.
- Configure grants for a newly added content type (defaults are auto-seeded on type creation).
- Keep author-only editing while removing author grants for anonymous-owned nodes automatically.
- Manage grant defaults entirely through exported `nodeaccess.settings` config for deployment.
- Search for and add specific users to a node's grant list from the Grants tab.
