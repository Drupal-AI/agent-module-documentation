<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Invite allows users to invite others to the site, with by-email and invite-link submodules, tracking invitations.

---

Invite lets users invite others to join the site — sending invitations (via the `invite_by_email`
submodule) or generating invite links (via `invite_link`), and tracking the invitation lifecycle
(sent/accepted). It is configured at `invite.invite` and provides its own permissions. Invitations can be
used to control/encourage registration (invite-only sites, referral flows).

Use it for invitation-based registration or referrals. The security-relevant points: an invitation
(especially an invite link) is effectively a **capability** — whoever holds a valid invite link can use it
to register/join, so invite tokens/links must be unguessable and ideally single-use/expiring; gate who can
send invitations via permissions (to prevent abuse/spam of the invite system), and treat invitee email
addresses as personal data. Verify the invite-token strength and single-use/expiry behaviour, and configure
who may invite.

---

- Let users invite others to the site.
- Send invitations by email.
- Generate invite links.
- Track invitation status.
- Configure at invite.invite.
- Provide its own permissions.
- Support invite-only registration.
- Enable referral flows.
- Treat invite links as capabilities.
- Ensure invite tokens are unguessable.
- Make invites single-use/expiring.
- Gate who can send invites.
- Prevent invite-system spam/abuse.
- Treat invitee emails as personal data.
- Verify token strength/expiry.
- Configure who may invite.
- Manage invitations.
- Handle invite lifecycle.
- Control registration by invite.
- Send referral invites.
