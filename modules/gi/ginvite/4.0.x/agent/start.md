# Group invite (ginvite) — agent index

Extends **Group**: adds a `group_invitation` relation plugin so managers can invite users/emails to
a group; invitees accept/decline and become members. Depends on `group` and `views`. No Drush.

- **Install the group_invitation relation on a group type + its plugin config (emails, expiry, etc.)
  and the pending-warning config object** → [configure/enable.md](configure/enable.md)
- **Invitation entities: statuses, the two fields, the loader service, accept/decline & bulk routes,
  creating an invitation programmatically** → [api/invitations.md](api/invitations.md)
- **Group permissions ginvite adds** → [permissions/permissions.md](permissions/permissions.md)

Key facts: relation plugin id `group_invitation` (entity_type user, admin permission
`administer group invitations`). Invitations are `group_relationship` entities (plugin
`group_invitation`) with locked fields `invitee_mail` (email) and `invitation_status` (int: 0
pending, 1 accepted, 2 rejected, 3 expired). Bulk form `ginvite.invitation.bulk`
(`/group/{group}/invite-members`); accept/decline at `/ginvite/{group_relationship}/accept|decline`.
Config object `ginvite.pending_invitations_warning`. Views `my_invitations`, `group_invitations`.
