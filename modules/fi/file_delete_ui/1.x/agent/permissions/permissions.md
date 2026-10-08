# Permissions & access

## The permission

`file_delete_ui.permissions.yml` defines one permission:

```yaml
delete any file:
  title: 'Delete any file'
  restrict access: true
```

`restrict access: true` marks it as security-sensitive on the *People → Permissions* page.

## Access rule (`FileAccessControlHandler::checkAccess()`)

The module overrides the core file access handler. For the `delete` operation it returns:

```php
AccessResult::allowedIfHasPermission($account, 'delete any file')
  ->orIf(AccessResult::allowedIf($entity->getOwnerId() == $account->id()))
  ->addCacheableDependency($entity);
```

So a user can delete a file entity if **either**:

- they hold the `delete any file` permission (delete *any* file on the site), **or**
- they are the file's owner (`uid` on the `file` entity equals the current user).

All other operations (`view`, `download`, `update`, …) fall through to the core
`file\FileAccessControlHandler` unchanged.

## Grant it

```bash
drush role:perm:add content_editor 'delete any file'
```

Or in config, the permission appears in `user.role.<role>.permissions`. Read it back with:

```bash
drush php:eval 'print var_export(\Drupal\user\Entity\Role::load("content_editor")->hasPermission("delete any file"), TRUE);'
```

Uid 1 bypasses the check as usual.
