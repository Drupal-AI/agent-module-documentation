<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Reference with Invite — configuration & flow

## Setup
1. Add a user-reference (entity_reference to `user`) field to any entity.
2. Set its form widget to **User Reference Invite** (`UserReferenceInviteWidget`).
3. Grant `invite users via reference fields` to editors; keep `administer user
   invitations` (restricted) for admins.
4. Configure defaults at `/admin/config/people/user-reference-invite`
   (`InviteSettingsForm`) — expiry, roles, email template behavior.

## Invitation flow
1. On the entity form, an editor picks an existing user OR types an email to invite.
2. `UserInviteManager` creates a `user_invite` entity; `TokenService` mints a
   256-bit token (`Crypt::randomBytesBase64(32)`) with an expiry.
3. An email (Drupal mail; HTML via htmlmail/swiftmailer/symfony_mailer) sends the
   accept link `/user/invite/accept/{token}`.
4. `InviteAcceptController::accept()` validates token existence + expiry, then routes
   the invitee through registration/login.
5. Post-registration subscribers attach the new account to the originating reference
   field and apply any context-specific role; login-redirect subscriber returns them
   to context.
6. `InviteCleanupSubscriber` removes expired invites; `InviteBatchQueueWorker` handles
   bulk sends.

## Admin operations (`/admin/people/invitations`, `InviteAdminController`)
List, cancel, **resend** (new token+expiry), **remind**. Member actions
(`InviteActionController`): transfer-ownership, remove-member, cancel — all gated by
`invite users via reference fields` (remove-member is POST-only).

## Security note
Only `user_reference_invite.accept` is `_access: 'TRUE'`; it is safe because access is
enforced by the unguessable, expiring token validated before any login. Everything else
is permission-gated.
