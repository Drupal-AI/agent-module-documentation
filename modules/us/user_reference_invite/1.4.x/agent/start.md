<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Reference with Invite (user_reference_invite) — agent index

**Adds an email invitation workflow to user-reference fields: invite new users, register them through a secure token link, and auto-attach them to the referencing entity.**

- **Version:** 1.4.x (1.4.0)
- **Core:** ^10 || ^11 — depends on `user`, `field`; suggests token, htmlmail, swiftmailer, symfony_mailer.
- **Entity:** `user_invite` (token + expiry). **Field widget:** `UserReferenceInviteWidget`.
- **Services:** `token_service` (`TokenService`), `invite_manager` (`UserInviteManager`), registration/cleanup/login-redirect/registration-access event subscribers, route subscriber, `UserRegisterAccess` access check; queue worker `InviteBatchQueueWorker`.
- **Routes:** admin list/cancel/settings (`administer user invitations`, restricted); resend/remind/transfer-ownership/remove-member/cancel (`invite users via reference fields`); `user/invite/accept/{token}` (`_access: TRUE`).
- **Permissions:** `administer user invitations` (restricted), `invite users via reference fields`, `view own invitations`, `cancel own invitations`.

**Security:** SOUND (reviewed). The only public route (`user_reference_invite.accept`, `_access: 'TRUE'`) is a deliberate capability link protected by a 256-bit CSPRNG token — `Crypt::randomBytesBase64(32)` in `TokenService` — validated as existing and not expired before login/registration finalizes; not a weak-token ATO. All other routes are permission-gated (admin routes restricted). No security findings.

See [configure/invitations.md](configure/invitations.md).
