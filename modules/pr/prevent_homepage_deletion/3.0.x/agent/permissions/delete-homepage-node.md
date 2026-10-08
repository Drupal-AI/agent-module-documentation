<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `delete_homepage_node` permission

`prevent_homepage_deletion.permissions.yml`:

```yaml
delete_homepage_node:
  title: 'Delete homepage node'
  description: 'Users with this permission are allowed to delete a homepage, 404, 403 or other protected node.'
  restrict access: false
```

Note the machine name uses **underscores**, not the usual spaced style.

Grant it:

```bash
drush role:perm:add site_owner delete_homepage_node
```

```php
user_role_grant_permissions('site_owner', ['delete_homepage_node']);
\Drupal\user\Entity\Role::load('site_owner')->hasPermission('delete_homepage_node'); // check
```

## What it gates

### 1. Deleting — `hook_node_access()`

```php
function prevent_homepage_deletion_node_access(EntityInterface $entity, $operation, AccountInterface $account) {
  if ($operation == 'delete') {
    if (!_prevent_homepage_deletion_check($entity, $account)) {
      if (!$account->isAnonymous()) { _prevent_homepage_deletion_show_message(); }
      return AccessResult::forbidden();
    }
    return AccessResult::neutral();
  }
  return AccessResult::neutral();
}
```

A `forbidden()` from any `hook_node_access()` implementation is a hard deny, so the *Delete*
tab and the delete link in the content overview disappear, and `/node/N/delete` returns 403.

### 2. Unpublishing — `hook_entity_field_access()`

For `$operation === 'edit'` on the **`status`** field of a **published** `Node`, the same check
runs and returns `AccessResult::forbidden()` when it fails. Practical effect: the *Published*
checkbox is removed from the node edit form, so a protected node cannot be unpublished.
(The check only applies while the node is published — an already-unpublished node can be
re-published.)

### 3. The explanatory message

`_prevent_homepage_deletion_show_message()` adds a messenger message when the current request
URI contains `/delete` **or** the POSTed `action` is `node_delete_action` — i.e. on the delete
confirm form and on the content-overview bulk "Delete content" action:

> You tried to delete a restricted page (homepage, 404, 403 or other specifically protected
> pages), but you do not have the permission to do so.

## Overrides and interactions

- **`bypass node access`** (core) short-circuits `hook_node_access()`, so users with it can
  still delete protected nodes. The module's own help text says so.
- User 1 likewise bypasses node access.
- The module returns `neutral()` for every non-`delete` operation, so it never grants anything —
  it only takes away.
- Because the check reads `system.site` and the module's own config on every access check but
  adds no cacheability metadata for them, changing either usually needs a cache clear before the
  new state is visible in rendered links.
