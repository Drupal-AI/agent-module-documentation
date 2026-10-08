# Configure protection rules & settings

## Manage rules (UI)

Routes (all `/admin/config/people/userprotect...`, permission `userprotect.administer`):

| Route | Path | Purpose |
|---|---|---|
| `userprotect.rule_list` | `/` | List protection rules (the `configure` route) |
| `userprotect.rule_add` | `/add` | Add a rule |
| `userprotect.rule_add_type` | `/add/{protected_entity_type_id}` | Add a rule for a given target type (default `user_role`) |
| `entity.userprotect_rule.edit_form` | `/manage/{userprotect_rule}` | Edit a rule |
| `entity.userprotect_rule.delete_form` | `/manage/{userprotect_rule}/delete` | Delete a rule |
| `userprotect.settings` | `/settings` | Module settings form |

## The `userprotect_rule` config entity

Config entity type `userprotect_rule` (config prefix `userprotect.rule`, so config names are
`userprotect.rule.{name}`). Exported keys: `name`, `label`, `uuid`, `protectedEntityTypeId`,
`protectedEntityId`, `protections`.

| Property | Meaning |
|---|---|
| `protectedEntityTypeId` | Target type: `user` (protect one account) or `user_role` (protect all users in a role). Default `user_role`. |
| `protectedEntityId` | The target user ID or role machine name. |
| `protections` | Sequence of enabled `user_protection` plugin instances (each with `id`, `status`, `weight`). |
| `status` | Whether the rule itself is enabled. |

A rule is applied to a user when `appliesTo()` matches (user ID equals, or user has the role).
`isProtected($user, $op, $account)` then returns TRUE if the matching protection plugin is
enabled for the operation. Enforcement happens in `hook_ENTITY_TYPE_access()`/`hook_entity_field_access()`
in `userprotect.module` — protected fields are disabled/hidden on `user/X/edit`; edit/cancel
are blocked by denying the `update`/`delete` entity operations.

### Exceptions (a rule never applies when)

- The operating account is **user 1**.
- The operating account holds **`userprotect.bypass_all`**.
- The operating account holds the rule's own bypass permission **`userprotect.{name}.bypass`**
  (each saved rule generates this; grant it to a role via the permissions page).
- The target user is **editing their own account** — self-editing is governed instead by the
  `userprotect.*.edit` permissions (see permissions doc), not by protection rules.

## Available protections (plugin IDs)

`user_name`, `user_mail`, `user_pass`, `user_status`, `user_roles`, `user_edit` (edit op),
`user_delete` (cancel op). See [plugins/plugins.md](../plugins/plugins.md).

## Settings — `userprotect.settings`

| Key | Default | Meaning |
|---|---|---|
| `display_applied_protections_message` | `true` | Show admins (with `administer users`) a message on the user edit form listing which protections were applied. |

Config schema: `config/schema/userprotect.schema.yml`. Both the settings object and rule
entities export with `drush config:export`. Rules are auto-deleted when their protected user
or role is deleted (`hook_user_delete` / `hook_user_role_delete`).
