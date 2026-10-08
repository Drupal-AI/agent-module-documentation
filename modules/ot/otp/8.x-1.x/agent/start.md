<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OTP for account creation (otp) — agent index

Replaces Drupal's registration email-verification **link** with a numeric **one-time code** that
the registrant types on a form. Version **8.x-1.1**, core `^8 || ^9 || ^10 || ^11`. Depends on
core `user` only; no services, plugin types, Drush commands, submodules, or module-defined
permissions.

Not to be confused with `one_time_password` (TOTP/HOTP **two-factor login**). This is
**registration-time email verification** and nothing else.

## Mechanism

1. `otp_install()` sets `user.settings:verify_mail` = `FALSE` (uninstall restores it to `TRUE`).
2. `otp_form_user_register_form_alter()` (in `otp.module`) rewrites the core register form for
   non-admins: new account defaults blocked, core `::save` is removed, submit becomes "Next",
   and `otp_user_register_submit()` runs instead.
3. `otp_user_register_submit()` saves the blocked account and calls `_otp_generate_otp()`:
   flood-checks `user_otp` (keyed by **email**), generates `random_int()` of `otp_no_of_digits`
   digits (default 6), emails it (`hook_mail()` key `send_otp`), stores **`md5($otp)`** + a
   timestamp in `user.data` (`otp` / `otp_user_register_random_otp`), sets
   `$_SESSION['otp_user_register_uid']`, and redirects to `/user/register/otp`.
4. `OTPVerifyForm` (`src/Form/OTPVerifyForm.php`, route `otp.user_register_otp`, `_access: 'TRUE'`)
   resolves the user from session uid / `?u=<uuid>` / admin-entered id-or-email, flood-checks
   `user_otp_submit`, compares `md5(input)` to the stored value, enforces a **24-hour** expiry,
   then `activate()` + `save()` + `user_login_finalize()` and deletes the stored code.
5. `OTPResend::sendOtp()` (`src/Controller/OTPResend.php`, route `otp.user_register_otp_resend`,
   `/user/register/otp/resend/{uuid}`) and a "Resend" button re-issue a code.

## Config (`otp.settings`, `/admin/config/people/otp`, `OTPSettingsForm`)

Gated by core `administer site configuration`. Keys: `otp_no_of_digits` (1-10),
`otp_otp_mail_subject`, `otp_otp_mail_body` (must contain `[user:otp]`; also supports
`[user:otp_form_url]`), `user_otp_generate_threshold` / `user_otp_generate_time_window` (hours),
`user_otp_submit_threshold` / `user_otp_submit_time_window` (hours). **The shipped
`config/install/otp.settings.yml` is all empty strings** — the flow only works after an admin
saves this form (an unsaved install flood-checks against an empty threshold and refuses to send).

## Routes

- `otp.settings` → `/admin/config/people/otp` (`_permission: administer site configuration`)
- `otp.user_register_otp` → `/user/register/otp` (`_access: 'TRUE'`)
- `otp.user_register_otp_resend` → `/user/register/otp/resend/{uuid}` (`_access: 'TRUE'`)

## Files

- `otp.module` — form alters, submit handler, `hook_mail`, `_otp_generate_otp()`, token replacement
- `otp.install` — toggles `verify_mail` on install/uninstall
- `src/Form/OTPVerifyForm.php` — the verify form and its validation/flood/expiry logic
- `src/Form/OTPSettingsForm.php` — admin settings
- `src/Controller/OTPResend.php` — resend controller
- `config/{install,schema}/otp.*.yml`, `otp.routing.yml`, `otp.links.menu.yml`

See `../usage.md` for the prose description and use-cases.
