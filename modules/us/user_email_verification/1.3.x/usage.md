Lets users set a password and log in immediately at registration, then requires them to verify their email within a configurable window via an emailed link — blocking (and optionally later deleting) the account if they do not. Fills the gap that core's own verification cannot: logging the user in right after registration while still enforcing verification.

---

On user insert the module records a verification row (`user_email_verification` table: uid, verified timestamp, last_reminder, reminders count, state). The site is configured so core does *not* require email verification at registration (so the user is logged in immediately), and a `[user:verify-email]` token is placed in the welcome mail to deliver the verification link. The link is `/user/user-email-verification/{uid}/{timestamp}/{hashed_pass}` where `hashed_pass` is an HMAC (`Crypt::hmacBase64`) keyed on the site hash salt plus uid — an anonymous-accessible controller checks the timestamp is within the *validate_interval*, the record exists and is unverified, and the HMAC matches before marking the email verified. `hook_cron` drives the enforcement: it queues reminder mails (up to *num_reminders* during the interval), then blocks accounts whose interval has elapsed (queue workers `UserEmailVerificationBlockAccount`, `…Reminders`). An optional *extended period* gives blocked users extra time with a second link (`…-extended/…`) that re-activates the account; when that expires the account is either deleted or left blocked depending on the core "when cancelling a user account" setting and `extended_end_delete_account`. Roles listed in *skip_roles* are exempt. The module adds: a settings form (`/admin/config/people/user-email-verification`), a `manage user email verification settings` permission (restricted), a notification block, a `user_email_verification_needed` cache context, extra user-display fields ("Email verified" / date), a Views filter, Rules events/conditions/actions (when Rules is installed), and events for verify/block/delete/reminder. Admins with `administer users` who activate a blocked user auto-verify that user's email (unless disabled). Verification links are HMAC-signed with the site secret, so they are not guessable/forgeable without the hash salt.

---

- Log users in immediately after registration but still force email verification afterward.
- Let users choose their own password on the registration form (no email round-trip to log in).
- Block accounts automatically when the email is not verified within a time window.
- Send an emailed, HMAC-signed verification link via the `[user:verify-email]` token.
- Send a configurable number of reminder emails during the verification window.
- Grant an extended grace period with a second link that re-activates a blocked account.
- Delete (or keep blocked) accounts that miss even the extended verification window.
- Exempt specific roles (e.g. admins, staff) from email verification via "Skip roles".
- Auto-verify a user's email when an admin manually activates their blocked account.
- Show an "Email verified" yes/no indicator and verification date on user profiles.
- Add a Views filter to list verified vs unverified users.
- Display a site notification block prompting the current user to verify their email.
- Let a user request a fresh verification email from `/user/user-email-verification`.
- Cache-vary rendered output on whether the current user still needs to verify.
- Translate verification email subjects/bodies with Configuration Translation.
- Trigger Rules reactions when an email is verified (standard or extended period).
- Trigger Rules when a verification/reminder mail is sent, or when a period is exceeded.
- Run a Rules action to (re)send a verification mail or mark a user's email verified.
- Enforce verification on an existing site (install seeds all current users as already verified).
- Customise verification and extended-period mail subject and body text.
- Set the verification and extended intervals (in seconds) per site policy.
- Prevent unverified users from lingering by combining blocking with account deletion.
- Handle the "already verified" and "expired link" cases with user-facing redirects/messages.
- Detect whether a given user still needs verification programmatically for custom logic.
