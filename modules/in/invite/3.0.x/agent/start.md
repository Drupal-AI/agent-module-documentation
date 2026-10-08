<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invite — agent index

Lets users **invite others to the site** — by email (`invite_by_email`) or **invite link** (`invite_link`),
tracking invitation lifecycle. Config at `invite.invite`; provides permissions. Version **3.0.x** (dev).
Core `^10||^11`.

**Security:** an invite link is a **capability** (holder can register/join) — ensure tokens are unguessable
+ single-use/expiring; gate who can send (prevent spam/abuse); invitee emails are personal data. Verify
token strength/expiry.
