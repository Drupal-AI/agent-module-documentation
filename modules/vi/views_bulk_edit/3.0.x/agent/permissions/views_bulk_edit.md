# Permissions

Defined in `views_bulk_edit.permissions.yml` (one permission).

| Permission | Machine name | Gates |
|---|---|---|
| Allow bulk edit of entities | `use views bulk edit` | Access to the confirm form at `/admin/content/bulk-edit` (route `views_bulk_edit.edit_form`), i.e. the core-Action (`entity:edit_action`) path. |

Notes:

- This permission guards the standalone confirm-form route only. The action itself is
  additionally gated **per entity** by `update` access — `ModifyEntityValues::access()` and
  `EditAction::access()` both check `$object->access('update', $account)`, so a user can only
  bulk-edit entities they may already edit.
- The VBO action (`views_bulk_edit`) is offered through the View's Views Bulk Operations
  field; its availability follows VBO's own access checks (and, if used, the
  `views_bulk_operations` Actions Permissions submodule) plus the same per-entity `update`
  check — it does not itself require `use views bulk edit`.

```
drush role:perm:add editor 'use views bulk edit'
```
