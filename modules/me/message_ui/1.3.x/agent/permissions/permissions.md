# Permissions

Defined in `message_ui.permissions.yml` plus a dynamic callback.

## Static permissions

| Permission | Gates |
|---|---|
| `bypass message access control` | Full CRUD on **any** message (grant to trusted users only) |
| `update tokens` | Manually/automatically update a message's tokens on the edit form |
| `view any message template` | View messages of any template |
| `edit any message template` | Edit messages of any template |
| `create any message template` | Create messages of any template |
| `delete any message template` | Delete messages of any template |
| `delete multiple messages` | Access the bulk `/admin/config/message/message_delete_multiple` form |

## Per-template permissions (dynamic)

`permission_callbacks: \Drupal\message_ui\MessagePermissions::messageTemplatePermissions`
generates four permissions **per Message template** (`MessageTemplate::loadMultiple()`):

```
view <template_id> message
update <template_id> message
create <template_id> message
delete <template_id> message
```

So a template `example_create_node` yields `create example_create_node message`, etc. These
appear on `/admin/people/permissions` under Message UI once templates exist, and are what
`MessageAccessControlHandler` / the route `_entity_create_access` checks (alongside the
`... any message template` and `bypass message access control` permissions).

Inspect the generated permissions with Drush:

```bash
drush php:eval '$p=\Drupal::service("user.permissions")->getPermissions();
print isset($p["create example_create_node message"]) ? "yes\n" : "no\n";'
```

Grant one to a role: `drush role:perm:add editor 'create example_create_node message'`.
