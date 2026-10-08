<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Message Invites extends the Private Message module so a thread manager can invite people into an existing private-message thread by email address; the invited user then accepts or declines the invitation.
---
An invite is stored as a `private_message_invite` content entity holding the target email, the thread reference (`pm_thread`), the creator (`created_by`) and an `invite_status` (pending/accept). The invite form (`/private-messages/{thread}/invite-members`) validates the email, rejects addresses that already belong to the thread and rejects duplicate invites. Accept (`/private-message-invite/{invite}/accept`) sets the status and appends the invited user to the thread's `members`; decline deletes the invite. A kernel request subscriber shows a warning message with a link to the recipient's pending-invitation view. A `views.view.my_pm_thread_invites` view and menu/action links surface the invites in the UI.

Access is gated: the invite form requires the `use private messaging system` and `invite members private messaging thread` permissions plus an authenticated user; the admin email-template config page requires `administer private message module`. The accept/decline routes use a custom access check (`checkAccess`) that only allows the invited user (when not yet a member) or the invite's creator, and returns forbidden otherwise — anonymous users (uid 0) never match. Two permissions are defined: *invite members private messaging thread* and *View Invitations*.
---
- Invite a user into a private-message thread by email address.
- Let invited users accept an invitation and join the thread.
- Let invited users decline an invitation.
- Let a thread creator withdraw (delete) a pending invitation.
- Notify logged-in users of pending invitations via a warning message + link.
- List a user's pending thread invitations through the bundled view.
- Grant the *invite members private messaging thread* permission to trusted roles.
- Grant the *View Invitations* permission for accept/decline access.
- Restrict invite-email template editing to *administer private message module*.
- Customise invitation email content at `/admin/config/private-message/invite`.
- Prevent inviting an address that is already a thread member (validation).
- Prevent sending a duplicate invitation to the same address/thread.
- Validate that the invite address is a well-formed email.
- Add an "Invite Members" action link on a thread page.
- Track invitation state via the `private_message_invite` entity.
- Redirect an accepting user to the joined thread canonical page.
- Audit who created each invitation via the `created_by` field.
- Integrate invitations into the Private Message UI menu.
