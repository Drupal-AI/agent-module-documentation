# Configuration

Invitations are configured **per group type**, plus a small site-wide reminder and a
set of group permissions. There is no single global settings form.

## 1. Install the invitation relation on a group type

Invitations work exactly like membership: they are a group **relation plugin** you
install on each group type that should support them.

1. Go to your Group types administration (**Administration → Groups → Group types**).
2. Open the group type you want, and manage its relation plugins / installed content.
3. Install **Group Invitation**.

Installing it creates the invitation content type for that group type and adds two
fields to invitations behind the scenes: the invitee's email address and the
invitation status.

## 2. Configure the invitation plugin

When you install (or later edit) the Group Invitation plugin on a group type, you can
set its behaviour. The main options are:

- **Email to a not-yet-registered invitee** — subject and body sent to someone invited
  by email address who does not yet have an account. Tokens for the group, user, and
  invitation are available in the body (for example a registration link). Sending this
  email is on by default.
- **Email to an existing user** — a separate subject and body for people who already
  have an account. Sending this one is off by default; turn it on if you want
  registered users emailed too.
- **Cancellation notice** — an optional subject and body sent when an invitation is
  revoked.
- **Expiry** — the number of days an open invitation stays valid before it expires
  (leave empty for never). You can also choose to **keep** expired invitations (marked
  as expired) instead of deleting them, which is useful for auditing.
- **Auto-accept invitees** — automatically accept an invitation when a new user
  registers with the invited email address.
- **Unblock invitees** — unblock accounts created from an invitation (on by default).
- **Bypass the accept form** — skip the confirmation step so accepting creates
  membership immediately.
- **Remove the invitation on join** — delete the invitation record once the user
  becomes a member.

Save the group type. Repeat for each group type that needs invitations, since these
settings are per type.

## 3. The pending-invitations reminder

The module can show a site-wide message to users who have invitations waiting ("You
have pending group invitations…"). This is controlled by the
`ginvite.pending_invitations_warning` configuration, where you can set the message text
and list routes on which the reminder should be suppressed (by default it is hidden on
the user profile and the accept/decline pages). You can adjust it with Drush:

```bash
drush cget ginvite.pending_invitations_warning
```

## 4. Group permissions

Who can invite is governed by **group permissions**, granted per group role on each
group type's permissions form (not the site-wide People → Permissions page). Group
invite adds:

| Permission | What it allows |
|---|---|
| **Invite users to group** | Create invitations. |
| **Bulk invite users to group** | Use the bulk invite form at `/group/{group}/invite-members`. |
| **View group invitations** | View a group's invitations. |
| **Delete own invitation** | Delete invitations the user created. |
| **Delete any invitation** | Delete any invitation. |
| **Administer group invitations** | Full administration of invitations. |

Grant these on the group roles (for example the "member" or a "manager" role) of the
group types where you installed the invitation plugin. They apply only within groups of
that type — they are not global site permissions.

## How members use it

Once a group type has invitations installed and a role has the right permissions:

- Managers invite people from the group's **Invite members** form
  (`/group/{group}/invite-members`) — one at a time or in bulk.
- Invitees see and manage their invitations on the **My invitations** tab of their user
  profile, where they accept (which creates their membership) or decline.
- The shipped **group invitations** View gives each group a list of its invitations,
  with an "Invite member(s)" action link.
