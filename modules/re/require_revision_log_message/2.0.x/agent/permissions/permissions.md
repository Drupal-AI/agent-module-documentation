# Permissions

Defined in `require_revision_log_message.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer require_revision_log_message` | Access to the settings form (`require_revision_log_message.admin_settings_form`, `/admin/config/require-revision-log/adminsettings`) where you pick which content types require a log message. | `restrict access: true` (security-sensitive). |
| `bypass require_revision_log_message` | Lets a user skip the requirement entirely — the node form is not altered for them. | Checked first in the form alter (`$user->hasPermission('bypass ...')` → early return). |

Grant example:

```bash
drush role:perm:add content_editor 'administer require_revision_log_message'
drush role:perm:add administrator 'bypass require_revision_log_message'
```

There are no other permissions; enforcement of the log message is otherwise automatic for
any role without the bypass permission on the configured content types.
