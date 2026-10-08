<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`site_settings.permissions.yml` defines ten permissions.

| Permission | Gates |
|---|---|
| `administer site setting entities` | The entity's `admin_permission`. Also the `_permission` of `/admin/config/site-settings/config`, `/admin/structure/site-settings`, the settings-type collection/add/edit routes and the replicate form. `restrict access: true`. |
| `access site settings overview` | `/admin/content/site-settings` (route `entity.site_setting_entity.collection`). Note it also reveals the settings **content** without `view published …`. `restrict access: true`. Also the `admin_permission` of `site_setting_group_entity_type`. |
| `add site setting entities` | Creating settings of any type. |
| `edit site setting entities` | Editing settings of any type. |
| `delete site setting entities` | Deleting settings of any type. |
| `view published site setting entities` | Viewing published settings. |
| `view unpublished site setting entities` | Viewing unpublished settings (also grants published). |
| `view all site setting entity revisions` | Viewing revisions. |
| `revert all site setting entity revisions` | Reverting revisions. |
| `delete all site setting entity revisions` | Deleting revisions. |

Access is decided by `SiteSettingEntityAccessControlHandler` for the content entity,
`SiteSettingEntityTypeAccessControlHandler` for the bundle config entity and
`SiteSettingGroupEntityTypeAccessControlHandler` for groups.

## Per-bundle permissions

The bundled submodule **`site_settings_type_permissions`** adds eight further permissions **per
settings type** (e.g. `edit phone_number site setting`) and OR-combines them with the global ones
above. See `../../../modules/site_settings_type_permissions/2.0.x/agent/permissions/per-type.md`.

## Typical grants

```bash
# a client editor who may manage values but not the structure
drush role:perm:add editor 'access site settings overview'
drush role:perm:add editor 'add site setting entities'
drush role:perm:add editor 'edit site setting entities'
drush role:perm:add editor 'view published site setting entities'

# a site builder who may define the types
drush role:perm:add site_builder 'administer site setting entities'
```

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("user_role")->loadMultiple() as $r) {
  $p = array_filter($r->getPermissions(), fn($x) => str_contains($x, "site setting"));
  if ($p) { print $r->id() . ": " . implode(", ", $p) . "\n"; }
}'
```

## A field-level quirk

`site_settings_entity_field_access_alter()` **forbids** access to the `description` base field
whenever `site_settings.config:hide_description` is TRUE — regardless of permission. Set that key
to FALSE if you need the description field to be editable or renderable.
