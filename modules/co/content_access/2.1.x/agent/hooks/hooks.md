# Hooks

Invitation hooks declared in `content_access.api.php`. Implement in `MODULE.module`.

## `hook_content_access_node_page($account, $route_match, $access_parameters, $access)`

Alter access to a node's **Access control settings page** (`/node/{node}/access`). Return an
`AccessResultInterface` (e.g. `AccessResult::forbidden()` / `::allowed()`). Called by the
`_content_access_node_page_access` check. Useful to open the page to, say, users allowed to edit
via ACL.

```php
function mymod_content_access_node_page(AccountInterface $account, RouteMatchInterface $route_match, array $access_parameters, AccessResultInterface $access): AccessResultInterface {
  return $access; // or AccessResult::allowed()->cachePerPermissions();
}
```

## `hook_content_access_per_node(array $settings, NodeInterface $node)`

Respond after per-node access settings are saved. `$settings` is keyed by operation
(`view`, `update`, `delete`, `view_own`, `update_own`, `delete_own`), each an array of role IDs.

## `hook_content_access_user_acl(array $view, array $view_own, array $update, array $update_own, array $delete, array $delete_own)`

Respond after the **ACL** module saves per-user grants from the node access tab. Each argument is
an array of role IDs for that operation.

## Deprecated (removed in 3.0.0)

- `hook_user_acl(...)` → use `hook_content_access_user_acl()`.
- `hook_per_node($settings, $node)` → use `hook_content_access_per_node()`.

## Core hook implemented (for reference)

The module implements `hook_node_access_explain($row)` to describe its grant rows in node access
reports (e.g. "Content access: %role can access", "author of the content can access").
