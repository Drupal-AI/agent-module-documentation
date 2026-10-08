<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `nodeaccess.permissions.yml` plus a dynamic callback
(`NodeGrantPermissions::permissions`).

| Permission | Machine name | Gates | restrict access |
|---|---|---|---|
| Administer Nodeaccess | `administer nodeaccess` | The settings form `/admin/config/people/nodeaccess` (route `nodeaccess.administration`) | yes |
| Grant all node permissions | `grant node permissions` | The **Grants** tab on **all** nodes, regardless of type | no |
| *(per content type)* %label: grant node permissions | `nodeaccess grant <node_type_id> permissions` | The Grants tab on nodes of **that** content type only | no |

The per-type permissions are generated for every content type by
`Drupal\nodeaccess\NodeGrantPermissions` (using `BundlePermissionHandlerTrait`). Note the
machine-name prefix `nodeaccess grant …` — it deliberately avoids colliding with
`grant node permissions` when a content type's id is `node`.

Access to the per-node Grants tab (`GrantsForm::access`) is granted if the user has
`grant node permissions` **or** the matching `nodeaccess grant <type> permissions` for the node's
type.

```bash
# Let a role manage grants on Article nodes only:
drush role:perm:add page_editor 'nodeaccess grant article permissions'
# Or on every node:
drush role:perm:add trusted 'grant node permissions'
```
