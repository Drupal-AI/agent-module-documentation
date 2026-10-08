<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User-form integration & provisioning

All wiring is in `crowd.module`, which forwards each hook to a class in `src/Hooks/*` via
`\Drupal::classResolver()`. Accounts are mapped to Crowd through the **externalauth** module
(`externalauth.authmap` / `externalauth.externalauth`) under provider id `crowd`.

## Login — `Hooks/Login`

- `crowd_form_user_login_form_alter` → `alterForm()`: injects the `crowd_login_finalise` validator
  right before core's `::validateFinal`. When `email_as_username` is on, relabels the name field
  to "Email address".
- `crowd_login_finalise` → `loginFinalise()`: runs only if core auth left `uid` empty (local
  password failed). Loads a user by name or email. If that user exists but is **not** mapped to
  the `crowd` provider (`authmap->get(...)` is empty), it returns and lets core's normal flow
  proceed. Otherwise it calls `connector->login($username, $password)`.
- On success: if no Drupal account exists yet, `externalauth->register()` provisions one with a
  random 50-char local password (so the local password can never be used) and syncs
  `given_name`/`surname`/`display_name`; the `verified_role` is added if configured. Sets `uid`
  and swaps in `loginComplete` as the submit handler, which calls `externalauth->login()` and
  stores the Crowd session token in the PHP session under key `crowd`.
- `crowd_user_logout` reads that session token and calls `connector->logout()` for single sign-off.

## Registration — `Hooks/Register`

- `crowd_form_user_register_form_alter` → `alterForm()`: prepends `crowd_user_register_validate`,
  makes email required, adds an admin-only **Local account** checkbox (create a plain Drupal
  account instead of a Crowd one), and hides the username field for non-admins when
  `email_as_username` is on.
- `validate()`: if *Local account* is checked, does nothing (normal Drupal registration).
  Otherwise swaps the submit handlers to `crowd_user_register_submit`, sets name=email when
  `email_as_username`, and rejects usernames/emails already taken in Crowd (`userExists`) or
  Drupal.
- `submit()`: `connector->register(...)` creates the Crowd user, then `externalauth->register()`
  creates the mapped Drupal account (again with a throwaway local password), copies extra field
  values, and sends the standard Drupal welcome / no-approval email so the user can verify via the
  reset link.

## Profile edit — `Hooks/Profile`

- `crowd_form_user_form_alter` → `alterForm()`: for Crowd-mapped users, forces email required,
  **disables the username field** (Crowd can't rename), disables the email field too when
  `email_as_username`, and adds descriptions for restricted domains. Inserts
  `crowd_user_form_initial_validation` first and `crowd_user_form_complete_validation` after core's
  `::validateForm`.
- `initialValidation()`: blocks email changes for restricted-domain users and when
  `email_as_username`. When email or password changes, requires the current password and validates
  it via `connector->login()` (admins editing another user are exempt). Temporarily sets
  `user_pass_reset` so core doesn't demand the dummy stored password; stashes the new password in
  `new_crowd_password` and replaces `pass` with a random value.
- `completeValidation()`: restores the original `user_pass_reset` flag.
- `submit()`: if a new password was entered, `connector->updatePassword()`; then
  `connector->updateUser()` writes name/email/first/last/display back to Crowd.
- `fieldAccess()` (`hook_entity_field_access`): forbids editing `given_name`/`surname`/
  `display_name` when the user's email domain is in `restricted_domains`; otherwise neutral.
- `hook_entity_extra_field_info` exposes a `local_account` pseudo-field on the user form.

## Password reset — `Hooks/PasswordReset`

- `crowd_form_user_pass_alter` adds `crowd_user_pass_validate` → `validateForm()`. If core already
  matched a Drupal account, or the account exists locally, it does nothing. If the entered
  name/email is unknown locally but `connector->getUser()` finds it in Crowd, it provisions the
  Drupal account (random local password, `verified_role` if set) and points the form's `account`
  element at it so core sends the reset email.

## Email verification & sync — `Hooks/AccountSync`

- `crowd_user_login` → `verifyAndSyncUserIfAppropriate()`: only for Crowd-mapped users. On the
  `user.reset.login` route (one-time login link = email verified), if not already verified it calls
  `connector->updateUserStatus($username)` to mark the Crowd account active and grants
  `verified_role`. On any other login it pulls the latest first/last/display names from Crowd and
  saves them to the Drupal user (`updateUserFromRemote`).

## TFA — `Hooks/Tfa` (dev/test dependency `tfa`)

- `crowd_form_tfa_setup_alter` inserts `crowd_tfa_setup_validate` and removes TFA's own
  `::validateForm`. `validateForm()` defers to core TFA for non-Crowd users or non-step-1; on the
  "enter current password" step it validates the password against Crowd via `connector->login()`,
  honoring the `administer tfa for other users` permission for admins acting on another account.
