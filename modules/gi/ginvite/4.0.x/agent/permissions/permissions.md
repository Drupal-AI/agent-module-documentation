# Group invite — permissions

These are **group permissions** (granted per group role via the group type's permissions form or a
`group_role` config entity), provided by `GroupInvitationPermissionProvider` for the
`group_invitation` relation plugin:

| Permission | Gates |
|---|---|
| `invite users to group` | create invitations (the relation's "create" operation) |
| `bulk invite users to group` | access the bulk invite form `/group/{group}/invite-members` |
| `view group invitations` | view invitations (the "view" operation) |
| `delete own invitation` | delete invitations you created |
| `delete any invitation` | delete any invitation |
| `administer group invitations` | full admin of invitations (the plugin's admin_permission) |

Notes:
- The relation plugin's `admin_permission` is `administer group invitations`.
- The bulk route accepts any of `bulk invite users to group` **+** `administer members` **+**
  `administer group invitations` (group's `_group_permission` OR-set).
- Grant them like any group permission, e.g. on a `group_role`:

```php
$role = \Drupal\group\Entity\GroupRole::load('my_type-member');
$role->grantPermission('invite users to group')->save();
```

These are distinct from site (global) permissions; they only apply within groups of the type whose
role you granted them on.
