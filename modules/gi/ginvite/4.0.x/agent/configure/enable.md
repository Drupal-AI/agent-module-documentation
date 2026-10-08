# Enable & configure invitations on a group type

Invitations are a Group **relation plugin** (`group_invitation`), installed per group type exactly
like the membership plugin.

## Install the relation on a group type

Via the UI: on the group type, *Set up content* / relation plugins → install **Group Invitation**.
This creates a `group_relationship_type` config entity (id like `<group_type>-group_invitation`).

Programmatically:

```php
$storage = \Drupal::entityTypeManager()->getStorage('group_relationship_type');
// GroupRelationshipTypeStorage::createFromPlugin(GroupType, plugin_id)->save()
$storage->createFromPlugin(\Drupal\group\Entity\GroupType::load('my_type'), 'group_invitation')->save();
```

Two fields are added to the `group_relationship` entity by this module (locked, enforced):
`invitee_mail` (email) and `invitation_status` (integer).

## Plugin configuration keys

The `group_invitation` plugin stores its config on the group relationship type (see
`defaultConfiguration()`), including:

| Key | Meaning |
|---|---|
| `invitation_subject` / `invitation_body` | email to a NOT-yet-registered invitee (tokens ok) |
| `send_email_not_existing_users` | send that email (default 1) |
| `existing_user_invitation_subject` / `_body` | email to an already-registered user |
| `send_email_existing_users` | send that email (default 0) |
| `cancel_user_invitation_subject` / `_body`, `send_cancel_email` | cancellation notice |
| `invitation_expire` | days until an open invite expires (empty = never) |
| `invitation_expire_keep` | keep expired invites (status 3) instead of deleting |
| `autoaccept_invitees` | auto-accept when a user registers with the invited email |
| `unblock_invitees` | unblock accounts created from an invitation (default 1) |
| `invitation_bypass_form` | skip the accept form; create membership immediately |
| `remove_invitation` | delete the invitation when the user joins |

Tokens available in bodies: `group`, `user`, `group_relationship` (e.g.
`[group_relationship:register_link]`, `[group_relationship:my_invitations_link]`).

Read/write the plugin config on the relationship type:

```bash
drush cget group.content_type.<id>   # the group_relationship_type config entity
```

## Pending-invitations warning

Config object `ginvite.pending_invitations_warning`:

```yaml
excluded_routes:                 # routes where the reminder is suppressed
  - entity.user.canonical
  - ginvite.invitation.accept
  - ginvite.invitation.decline
warning_message: 'You have pending group invitations. <a href="@my_invitations_url">Visit your profile</a> to see them.'
```

## Shipped Views

- `my_invitations` — the invitee's "My invitations" list (a user tab).
- `group_invitations` — a per-group list of invitations (has an "Invite member(s)" action link).
