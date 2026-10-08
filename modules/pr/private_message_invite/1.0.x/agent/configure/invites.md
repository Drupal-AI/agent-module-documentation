<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message Invites — configure & flow

## Permissions (private_message_invite.permissions.yml)
- `invite members private messaging thread` — send invitations.
- `View Invitations` — view/accept/decline invitations.
Grant with e.g. `drush role:perm:add authenticated 'invite members private messaging thread'`.

## Routes (private_message_invite.routing.yml)
| Route | Path | Access |
|-------|------|--------|
| invite_members | `/private-messages/{private_message_thread}/invite-members` | `use private messaging system` + `invite members private messaging thread`, logged in |
| admin_config.config | `/admin/config/private-message/invite` | `administer private message module` |
| accept | `/private-message-invite/{private_message_invite}/accept` | custom `checkAccess` |
| decline | `/private-message-invite/{private_message_invite}/decline` | custom `checkAccess` |

## checkAccess (PrivateMessageInviteController)
Allowed only when the current user is the invited user and not yet a thread member, or is the invite's `created_by`. Otherwise `AccessResult::forbidden()`.

## Invite flow
1. Open a thread, use the **Invite Members** action link.
2. Enter an email. Validation rejects invalid emails, existing members and duplicate invites.
3. Submit -> a `private_message_invite` entity is created (`invite_status = 0` pending, `created_by = current user`).
4. Invitee visits accept URL -> status set to ACCEPT and their uid appended to the thread `members`, redirected to the thread.
5. Decline URL -> invite deleted.

## Email templates
`/admin/config/private-message/invite` renders `ConfigForm` to edit invitation email content.
