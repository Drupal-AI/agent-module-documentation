<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client hooks (`acl.api.php`)

These are hooks a **client module** implements — ACL calls them. They are not implemented by
ACL itself.

## `hook_enabled()` — REQUIRED for your grants to apply

ACL only emits a node grant for an `acl_node` row if the owning module confirms it is active.
It calls `\Drupal::moduleHandler()->invoke($module, 'enabled')` in `hook_node_access_records()`.
So a client module `mymodule` must implement `mymodule_enabled()` returning TRUE:

```php
/**
 * Implements hook_enabled().
 */
function mymodule_enabled($set = NULL) {
  static $enabled = TRUE;   // note: not drupal_static()
  if ($set !== NULL) {
    $enabled = $set;
  }
  return $enabled;
}
```

If your module does **not** implement this (or it returns falsy), ACL will not return your
`acl` grant records — access will fall through to other realms. The optional `$set` argument
lets you toggle it off during `hook_disable`-style teardown.

## `hook_acl_explain()` — OPTIONAL, for the node-access debug UI

Return a human-readable explanation of what one of your ACL grant records means; shown by
`hook_node_access_explain()` (used by the devel/node-access debug screen).

```php
/**
 * Implements hook_acl_explain().
 */
function mymodule_acl_explain($acl_id, $name, $figure, $users = NULL) {
  if (empty($users)) {
    return "ACL (id=$acl_id) would grant access to $name/$figure.";
  }
  return "ACL (id=$acl_id) grants access to $name/$figure to the listed user(s).";
}
```

The function name is `{module}_acl_explain` where `{module}` is the `module` you passed to
`acl_create_acl()`.
