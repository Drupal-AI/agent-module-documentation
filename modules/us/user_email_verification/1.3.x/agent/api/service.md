# API — service, links, events, plugins

## `user_email_verification.service` (`UserEmailVerificationInterface`)

The single entry point. Inject it or `\Drupal::service('user_email_verification.service')`.

State constants: `STATE_IN_PROGRESS=0`, `STATE_APPROVED=1`, `STATE_BLOCKED=2`, `STATE_DELETED=3`,
`STATE_ON_HOLD=4`. Table `user_email_verification` (`VERIFICATION_TABLE_NAME`).

Selected methods:

- Records: `createVerification(UserInterface $user, $verify = FALSE)`,
  `deleteVerification(UserInterface $user)`, `loadVerificationByUserId($uid)`,
  `setEmailVerifiedByUserId($uid)`.
- Config getters: `getValidateInterval()`, `getExtendedValidateInterval()`, `getNumReminders()`,
  `getReminderInterval()`, `getSkipRoles()`, `getMailSubject()/Body()`,
  `getExtendedMailSubject()/Body()`, `isExtendedPeriodEnabled()`,
  `isCreationAutoVerificationAllowed()`, `isUnblockAutoVerificationAllowed()`,
  `shouldUserAccountDeleteOnEndOfExtendedInterval()`.
- Link building: `buildVerificationUrl(UserInterface $user): Url`,
  `buildExtendedVerificationUrl(UserInterface $user): Url`, `buildHmac($uid, $timestamp): string`.
- Enforcement: `cronHandler()`, `blockUserAccountById($uid)`, `deleteUserAccountById($uid)`,
  `remindUserById($uid)`, `sendVerifyMailById($uid)`, `sendVerifyBlockedMail(UserInterface $user)`.
- Queries: `isVerificationNeeded($uid = 0)`, `isReminderNeeded($uid)`,
  `isVerificationPeriodExceeded($uid)`, `isVerificationExtendedPeriodExceeded($uid)`,
  `getUserByNameOrEmail($name_or_email, $active_only)`.

## Verification links and the HMAC

Routes (all `_access: 'TRUE'` — anonymous by design, since the recipient may be logged out):

- `user_email_verification.verify` — `/user/user-email-verification/{uid}/{timestamp}/{hashed_pass}`
- `user_email_verification.verify_extended` — `/user/user-email-verification-extended/{uid}/{timestamp}/{hashed_pass}`
- `user_email_verification.request` — `/user/user-email-verification` (request a new link)

Token: `buildHmac($uid, $timestamp) = Crypt::hmacBase64($timestamp . $uid, Settings::getHashSalt() . $uid)`.
The controller (`UserEmailVerificationVerify::verify`) accepts only if: `now - timestamp <=`
interval; a verification record exists and is unverified; if the visitor is authenticated their uid
matches `{uid}`; and `hashed_pass === buildHmac(...)`. The key is the **site hash salt**, so links are
not forgeable/guessable without that secret. The extended controller additionally calls
`$user->activate()` to unblock. Tokens `[user:verify-email]` / `[user:verify-email-extended]` render
these URLs.

## Events (`UserEmailVerificationEvents`)

Symfony events dispatched by the service/controllers: `VERIFY`, `VERIFY_EXTENDED`, plus
create/block/delete and reminder events (see `src/Event/*`). Subscribe to react to a verification,
blocking, or deletion in custom code. `UserEmailVerificationVerifyEvent::notifyAsBlocked()` governs
the blocked-user branch.

## Cache context

`user_email_verification_needed` — vary render output on whether the current user still needs to
verify (used by the profile "Email verified" fields and the notification block).

## Plugins provided (instances, not new plugin types)

- **Block** `user_email_verification_notification` — a prompt for the current user to verify.
- **Views filter** `EmailVerification` — filter users by verified state.
- **Rules** (only when `rules` is enabled): conditions `…PeriodExceeded`,
  `…ExtendedPeriodExceeded`, `…UserEmailVerified`; actions `…SendNotificationMail`,
  `…VerifyUserEmail`; and reaction events declared in `user_email_verification.rules.events.yml`
  (email verified / reminder sent, standard + extended). `hook_condition_info_alter` removes the
  conditions when Rules is absent.
- **Queue workers** `…_block_account`, `…_reminders`, `…_delete_account` (driven by cron).

## Auto-verify on admin activation

`hook_user_presave`: if `isUnblockAutoVerificationAllowed()` and the current user has
`administer users` and is activating a previously-blocked account, the target's email is marked
verified automatically.
