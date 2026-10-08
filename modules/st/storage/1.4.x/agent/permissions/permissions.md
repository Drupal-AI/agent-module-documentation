<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Global permissions (`storage.permissions.yml`)

| Permission | Gates |
|---|---|
| `administer storage entities` | Full access (the entity `admin_permission`); create/edit/delete all. |
| `add storage entities` | Create new storage entities (generic). |
| `access storage overview` | The `/admin/content/storage` listing view. |
| `edit storage entities` / `edit own storage entities` | Edit any / own. |
| `delete storage entities` / `delete own storage entities` | Delete any / own. |
| `view published storage entities` | View published items. |
| `view own unpublished storage entities` / `view unpublished storage entities` | View unpublished (own / all). |
| `view all storage revisions` / `revert all storage revisions` / `delete all storage revisions` | Revision ops across all types. |

## Per-bundle permissions (`StoragePermissions::generatePermissions`)

For **each** storage type `<type>` the module generates:

```
add <type> storage entities
view published <type> storage entities
view unpublished <type> storage entities         (restricted)
view own unpublished <type> storage entities
edit own <type> storage entities
edit any <type> storage entities                 (restricted)
delete own <type> storage entities
delete any <type> storage entities               (restricted)
view <type> storage revisions
revert <type> storage revisions
delete <type> storage revisions
```

So access is controlled at bundle granularity (`permission_granularity = bundle`): grant a
role only the per-type permissions it needs. Revision permissions also require the matching
view/edit/delete permission on the item itself. The `has_canonical` storage-type flag governs
whether viewing at `/storage/{id}` is possible at all — with it off, that route redirects to
the edit form (and may 404 without edit access).
