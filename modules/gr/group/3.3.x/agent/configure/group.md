# Configure group types, roles & content

![Group types list](../../../../../../../screenshots/group/3.3.x/group-types.png)

## Entities you configure

| Config entity | Purpose |
|---|---|
| `group_type` | A bundle of `group`. Holds label, description, revisioning default and group-creator behaviour. |
| `group_role` | A role scoped to a group type (see scopes below); carries the group permissions it grants. |
| `group_relationship_type` | Created when you install a `GroupRelationType` plugin onto a group type; ties a plugin (+ config) to a group type. |

## Admin routes (all under `/admin/group`)

| Route | Path | Gate |
|---|---|---|
| `group.settings` | `/admin/group/settings` | `administer group` |
| entity.group_type.* (collection/add/edit) | `/admin/group/types` | `administer group` |
| `entity.group_type.permissions_form` | `/admin/group/types/manage/{group_type}/permissions` | `administer group` |
| `entity.group_type.content_plugins` | `/admin/group/types/manage/{group_type}/content` | `administer group` |
| `entity.group_role.permissions_form` | `/admin/group/types/manage/{group_type}/roles/{group_role}/permissions` | `administer group` |
| `entity.group_relationship_type.add_form` | `/admin/group/content/install/{group_type}/{plugin_id}` | `administer group` |
| `entity.group_relationship_type.edit_form` | `/admin/group/content/manage/{group_relationship_type}` | `administer group` |
| `entity.group_relationship_type.delete_form` | `/admin/group/content/manage/{group_relationship_type}/uninstall` | `administer group` |

The **content** page (`entity.group_type.content_plugins`) is where you install/uninstall the
relation plugins (e.g. Group membership, Group node) that decide which entity types the group
type can relate.

## Group role scopes — `Drupal\group\PermissionScopeInterface`

Every `group_role` has a `scope`:

- `outsider` — applies to users who are **not** members; synchronizes with a sitewide `global_role`.
- `insider` — applies to users who **are** members; also synchronizes with a `global_role`.
- `individual` — assigned to specific memberships (e.g. group admin, editor).

`SYNCHRONIZED_IDS = [outsider, insider]`. Synchronized roles derive their members from a
global role; individual roles are stored on the membership.

## `group.settings` (config object)

`config/install/group.settings.yml` — one key:

| Key | Default | Meaning |
|---|---|---|
| `use_admin_theme` | `TRUE` | Use the admin theme when creating/editing groups |

Change with `drush cset group.settings use_admin_theme 0`.

## group_type config keys (`group.type.*`)

`new_revision`, `creator_membership` (creator auto-joins), `creator_wizard` (creator must
finish their membership immediately), `creator_roles` (individual roles the creator receives).

## group_role config keys (`group.role.*`)

`admin` (grants everything), `scope`, `global_role` (for outsider/insider), `group_type`,
`permissions` (sequence of granted group-permission strings).

Config schema: `config/schema/group.schema.yml`. All three entity types are config, so they
export/deploy with `drush config:export`. No Drush commands are provided by the module itself.
