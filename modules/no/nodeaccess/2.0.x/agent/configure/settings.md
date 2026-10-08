<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings (`nodeaccess.settings`)

Settings form at `/admin/config/people/nodeaccess` (route **`nodeaccess.administration`**,
permission `administer nodeaccess`). Everything is stored in the **`nodeaccess.settings`** config
object.

## Config keys

| Key | Shape | Meaning |
|---|---|---|
| `allowed_grant_operations` | `{grant_view: bool, grant_update: bool, grant_delete: bool}` | Which grant columns are offered on the Grants tab / role grid. All TRUE by default. |
| `bundles_roles_grants` | `{<bundle>: {<role_id>|author: {grant_view:int, grant_update:int, grant_delete:int}}}` | **Per-content-type default grants** applied to nodes that have no per-node grants. `author` is a pseudo-role for the node owner. |
| `grants_tab_availability` | `{<bundle>: bool}` | Whether the per-node **Grants** tab is available for that content type. |
| `map_rid_gid` | `{<role_id>: <int gid>}` | Maps each role machine id to the numeric **grant id** used in the `node_access`/`nodeaccess` tables and in `hook_node_grants()`. |
| `roles_settings` | `{<role_id>: {display_name, name, weight:int, selected:bool}}` | Which roles are **selectable** on the Grants tab (`selected`) and their display order. |

These are seeded on install and kept in sync automatically: creating a content type
(`hook_node_type_insert`) adds a `bundles_roles_grants[<bundle>]` block and a
`grants_tab_availability[<bundle>] = FALSE` entry; creating/updating/deleting a **role** updates
`bundles_roles_grants`, `map_rid_gid`, and `roles_settings` via the `nodeaccess.helper` service.

## Read / write

```bash
drush config:get nodeaccess.settings bundles_roles_grants
```

```php
$cfg = \Drupal::configFactory()->getEditable('nodeaccess.settings');
$grants = $cfg->get('bundles_roles_grants');
// Default: give the 'editor' role view+update on every Article that has no per-node grants.
$grants['article']['editor'] = ['grant_view' => 1, 'grant_update' => 1, 'grant_delete' => 0];
// Let authors edit their own Articles by default.
$grants['article']['author'] = ['grant_view' => 1, 'grant_update' => 1, 'grant_delete' => 0];
$cfg->set('bundles_roles_grants', $grants)->save();
\Drupal::service('node.grant_storage'); // (grants are applied on node access rebuild)
node_access_needs_rebuild(TRUE);
```

To make the Grants tab appear for a type and expose a role there:

```php
$cfg = \Drupal::configFactory()->getEditable('nodeaccess.settings');
$avail = $cfg->get('grants_tab_availability'); $avail['article'] = TRUE;
$roles = $cfg->get('roles_settings');          $roles['editor']['selected'] = TRUE;
$cfg->set('grants_tab_availability', $avail)->set('roles_settings', $roles)->save();
```

## Important behavior

- **Per-node grants override the bundle defaults.** If a node has rows in the `nodeaccess` table
  (set via its Grants tab), `hook_node_access_records()` uses those and ignores
  `bundles_roles_grants` for that node. See [../api/grants.md](../api/grants.md).
- `grant_view` is additionally gated by publish status per translation — an unpublished
  translation is not granted view even if `grant_view` is 1.
- After changing grants you must let node access rebuild (`node_access_needs_rebuild(TRUE)` is
  called by the module; a full rebuild happens via *Rebuild permissions* or `drush php:eval
  'node_access_rebuild();'`).
