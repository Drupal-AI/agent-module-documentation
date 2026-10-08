<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message Invites (private_message_invite) — agent index

**Thread authors invite people (by email) into a Private Message thread; invitees accept or decline.**

- **Version:** 1.0.x (release 1.0.7)
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Requires:** private_message
- **Configure:** `private_message_invite.admin_config.config` (`/admin/config/private-message/invite`, perm `administer private message module`)
- **Routes:**
  - `invite_members` `/private-messages/{thread}/invite-members` — perms `use private messaging system` + `invite members private messaging thread`, must be logged in.
  - `accept` / `decline` `/private-message-invite/{invite}/(accept|decline)` — `_custom_access` `PrivateMessageInviteController::checkAccess`.
- **Permissions:** `invite members private messaging thread`, `View Invitations`.
- **Entity:** `private_message_invite` (invite_email, pm_thread, created_by, invite_status).
- **Security:** Invite/admin routes are permission-gated and require login. accept/decline are limited by custom access to the invited user (when not already a member) or the invite creator; all others forbidden, anonymous never matches. No `_access: TRUE` and no anonymous mutation endpoints.

See [configure/invites.md](configure/invites.md).
