<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`localgov_directories.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer directory facets types` | **true** | Facet **type** config entities (`localgov_directories_facets_type`) — also the entity type's `admin_permission`, so it implies full control of facet values |
| `access directory facets overview` | — | The facet listing at `/admin/content/directories/facets` |
| `create directory facets` | — | Create facet values |
| `edit directory facets` | — | Edit facet values |
| `delete directory facets` | — | Delete facet values |
| `view directory facets` | — | View facet values |

Facet **values** are content, so the four CRUD permissions are ordinary editorial permissions and
are checked by `LocalgovDirectoriesFacetsAccessControlHandler`. Facet **types** are config and sit
behind the restricted permission — that split is the whole point of the design: editors curate
values in production, site builders own the types.

## LocalGov default roles

`hook_localgov_roles_default()` grants the LocalGov **editor** role
(`RolesHelper::EDITOR_ROLE`):

```
access directory facets overview
create directory facets
edit directory facets
delete directory facets
view directory facets
create localgov_directory content
edit any localgov_directory content
edit own localgov_directory content
delete any localgov_directory content
delete own localgov_directory content
view localgov_directory revisions
revert localgov_directory revisions
```

These are applied by `localgov_core`'s role-defaults mechanism when roles are (re)built — not by
this module directly. On a non-LocalGov site nothing is granted automatically; assign them
yourself:

```bash
drush role:perm:add content_editor 'access directory facets overview'
drush role:perm:add content_editor 'create directory facets'
drush role:perm:add content_editor 'edit directory facets'
drush role:perm:add content_editor 'view directory facets'

# Who can administer the types?
drush php:eval 'foreach (\Drupal\user\Entity\Role::loadMultiple() as $r) { if ($r->hasPermission("administer directory facets types")) print $r->id() . "\n"; }'
```

## Notes

- Entry and channel **nodes** use ordinary node permissions per bundle
  (`create localgov_directory content`, plus whatever the entry bundles define) — this module adds
  nothing extra for them.
- `administer directory facets types` is the entity type's `admin_permission`, so granting it
  bypasses the individual facet-value permissions entirely. Keep it to site builders.
- The facet **values** are excluded from config export; access to create them is therefore a
  production-content decision, not a deployment one.
