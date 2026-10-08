# Programmatic API

Content Access exposes **procedural functions** (in `content_access.module`), not a service.
Operations are the keys `view`, `view_own`, `update`, `update_own`, `delete`, `delete_own`
(`update`/`delete` mean edit/delete; core edit/delete permissions back them). Roles are referenced
by role machine-name IDs.

## Read / write content-type settings

```php
// Read one setting (or 'all') for a content type. Throws if the type is missing.
$roles = content_access_get_settings('view', 'article');   // array of role IDs
$all   = content_access_get_settings('all', 'article');     // full settings array
$per   = content_access_get_settings('per_node', 'article'); // bool

// Write settings for a content type (stored as node-type third-party settings).
content_access_set_settings([
  'view'     => ['anonymous', 'authenticated'],
  'update'   => ['editor'],
  'per_node' => TRUE,
  'priority' => 0,
], 'article');
```

`content_access_available_settings()` returns the valid setting keys;
`content_access_get_setting_defaults($type)` returns the per-type defaults.

## Per-node settings

```php
content_access_save_per_node_settings($node, $settings); // writes to {content_access} table
$settings = content_access_get_per_node_settings($node);  // raw row, no defaults ([] if none)
$roles    = content_access_per_node_setting('view', $node); // effective roles (falls back to type)
content_access_delete_per_node_settings($node);            // reset node to type defaults (+ clears ACLs)
```

After changing settings, re-acquire and write grants so core picks them up:

```php
$grants = \Drupal::entityTypeManager()->getAccessControlHandler('node')->acquireGrants($node);
\Drupal::service('node.grant_storage')->write($node, $grants);
// Bulk across types (rebuilds if under the mass-update threshold, else flags a rebuild):
content_access_mass_update(['article', 'page']);
```

## Node grants integration (how access is computed)

- `content_access_node_grants($account, $op)` — **`hook_node_grants()`**: returns grant IDs for
  realms `content_access_author` (`[uid]`) and `content_access_roles` (the account's role GIDs).
- `content_access_node_access_records($node)` — **`hook_node_access_records()`**: builds the grant
  rows (per translation, published only), applying per-node settings when `per_node` is on, else
  the content-type defaults, then optimizes them (`content_access_optimize_grants()`) so only
  grants that differ from core permissions are written.
- `content_access_get_role_gid($role)` — role machine name → numeric grant ID (from the
  `content_access.settings` map).

## ACL helpers (require the `acl` module)

`content_access_get_acl_id($node, $op)` returns/creates the ACL id named
`content_access:{op}_{nid}`. Deleting per-node settings also removes the node's ACLs.

See also the **[hooks doc](../hooks/hooks.md)** for `hook_content_access_per_node()`,
`hook_content_access_user_acl()`, and `hook_content_access_node_page()`.
