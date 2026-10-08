Group invite (ginvite) extends the Group module so group managers can invite people — existing users or email addresses — to join a group; invitees accept or decline, and on acceptance receive group membership.

---

The module ships a Group **relation plugin** `group_invitation` (a `GroupRelationType` on the `user` entity, pretty path key `invitee`, admin permission `administer group invitations`). You install it on a group type just like membership, which creates a `group_relationship_type` and lets you configure the plugin: invitation email subject/body (with tokens), separate templates for existing vs new users, a cancellation notice, expiry (`invitation_expire` days, `invitation_expire_keep`), auto-accept/unblock of invitees on registration, and options to bypass the accept form or remove the invitation on join. Invitations are stored as `group_relationship` entities of plugin `group_invitation`, carrying two locked fields: `invitee_mail` (email) and `invitation_status` (integer: 0 pending, 1 accepted, 2 rejected, 3 expired). A bulk-invite form lives at `/group/{group}/invite-members` (route `ginvite.invitation.bulk`), and invitees accept/decline at `/ginvite/{group_relationship}/accept` and `/decline`. An event subscriber handles registration/login flows (firing `UserRegisteredFromInvitationEvent` / `UserLoginWithInvitationEvent`), and a `ginvite.pending_invitations_warning` config object shows a "you have pending invitations" message (with configurable `excluded_routes`). Two Views ship: `my_invitations` (user profile tab) and `group_invitations` (per-group list). Group permissions include `invite users to group`, `bulk invite users to group`, `view group invitations`, `delete own invitation`, `delete any invitation`, and `administer group invitations`. Services include `ginvite.invitation_loader` (wraps invitation relationships) and `ginvite.group_invitation_manager`. There are no Drush commands.

---

- Let group admins invite existing users to join their group by username.
- Invite people who don't yet have an account by email address.
- Send a branded invitation email using tokens for group and site name.
- Bulk-invite many users/emails at once from the group's invite-members form.
- Let invitees accept or decline an invitation from their profile's "My invitations" tab.
- Auto-accept an invitation when a new user registers with the invited email.
- Automatically unblock invitee accounts created from an invitation.
- Expire open invitations after a set number of days.
- Keep expired invitations (as status 3) for auditing instead of deleting them.
- Send a cancellation email when an invitation is revoked.
- Show a site-wide reminder to users who have pending invitations.
- Use separate email templates for already-registered users vs brand-new invitees.
- Bypass the membership form so accepting immediately creates the membership.
- Remove the invitation record once the user joins the group.
- Restrict who can invite via the per-group-role 'invite users to group' permission.
- List all pending invitations for a group via the group_invitations View.
- Track invitation state (pending/accepted/rejected/expired) via invitation_status.
- Build onboarding flows that invite users into a group on signup.
- Delegate invitation management to group managers, not just site admins.
- Let users delete their own sent invitations (delete own invitation permission).
- Notify group managers of invitation activity through the event subscriber.
- Integrate custom logic on invitation-driven registration via the dispatched events.
- Gate invitation viewing with the 'view group invitations' permission.
- Support email-only invitations that convert to membership after registration.
