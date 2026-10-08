# file_replace — permissions

One permission, defined in `file_replace.permissions.yml`:

| Permission | Machine name | `restrict access` | Gates |
|---|---|---|---|
| Replace files | `replace files` | `true` (marked security-sensitive in the UI) | Access to the replace form / route `entity.file.replace_form` and the "Replace" entity operation/link. |

## Access rules

Reaching `/admin/content/files/replace/{file}` requires **both**:

1. The `replace files` permission (route `_permission` requirement).
2. A custom access check (`_file_replace_access`, service `access_check.file_replace.editable_usages`,
   class `Drupal\file_replace\Access\FileReplaceAccessCheck`) that returns *allowed* only when the
   account has `replace files` **and** the target file `->isPermanent()`. Temporary / unmanaged files
   cannot be replaced.

The auto-added "Replace" entity operation (`hook_entity_operation`) and the Views "Link to replace
file" field both check `->access()` on the `replace-form` URL, so they only render for users who pass
the above.

## Granting via drush

```bash
drush role:perm:add editor 'replace files'
```

Because it is a sensitive permission, grant it only to trusted roles — a user who can replace a file
overwrites content served at an existing, possibly widely-linked URL.
