# Configure — classify roles

## Settings form

| | |
|---|---|
| Route | `administerusersbyrole.settings` |
| Path | `/admin/config/people/administerusersbyrole` |
| Menu | **Administration → People → Administer Users by Role** (parent `user.admin_index`) |
| Access | core `administer permissions` (`_permission` on the route) |
| Form class | `Drupal\administerusersbyrole\Form\SettingsForm` |
| Config object | `administerusersbyrole.settings` |

The form (`SettingsForm`) lists every **managed role** — all roles except anonymous,
authenticated, and any role that already has core `administer users` — as a required select
with three options:

| Option label | Stored value | Constant | Meaning |
|---|---|---|---|
| Allowed | `safe` | `AccessManagerInterface::SAFE` | Sub-admins with the matching base permission (`edit/cancel/view/role-assign users by role`) can manage users holding this role. |
| Forbidden | `unsafe` | `AccessManagerInterface::UNSAFE` | Sub-admins can never manage users holding this role (default for unset roles). |
| Custom | `perm` | `AccessManagerInterface::PERM` | Access is governed by the four extra per-role permissions this role then generates (`edit users with role {rid}`, etc.). |

Classify each role **before** assigning permissions — the per-role permissions only appear on
the permissions page for roles set to Custom.

## Config storage & schema

Stored as a single sequence keyed by role id:

```yaml
# administerusersbyrole.settings
roles:
  editor: safe
  moderator: perm
  administrator: unsafe
```

Default install value is `roles: {}` (config/install). Schema
(`config/schema/administerusersbyrole.schema.yml`) types it as a `config_object` whose `roles`
is a sequence of strings — so it exports/deploys with `drush config:export`.

Read or set individual entries with drush:

```
drush cget administerusersbyrole.settings roles
drush cset administerusersbyrole.settings roles.editor safe
```

When any role is created, updated or deleted, `hook_user_role_*` calls
`AccessManager::rolesChanged()`, which re-syncs the `roles` map (defaulting new/unset managed
roles to `unsafe`).
