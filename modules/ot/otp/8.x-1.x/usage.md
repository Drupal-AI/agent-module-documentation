<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OTP for account creation replaces Drupal's registration email-verification *link* with a numeric one-time code the registrant types on a form to activate the account.

---

Enabling the module runs `otp_install()`, which sets `user.settings:verify_mail` to `FALSE`, and `otp_form_user_register_form_alter()` rewrites the core user-registration form for non-admin submitters: the new account defaults to blocked (`status` = FALSE), core's `::save` handler is removed, the submit button becomes "Next", and `otp_user_register_submit()` takes over. That handler saves the (blocked) account, then calls `_otp_generate_otp()`, which checks the `user_otp` flood (keyed by the account email, `user_otp_generate_threshold` requests per `user_otp_generate_time_window` hours), generates a code with `random_int()` of `otp_no_of_digits` digits (1-10, default 6), emails it through `hook_mail()` key `send_otp` (subject/body from config with `[user:otp]` and `[user:otp_form_url]` tokens), stores `md5($otp)` and a timestamp in `user.data` (module `otp`, keys `otp_user_register_random_otp` / `..._time`) and puts the uid in `$_SESSION['otp_user_register_uid']`; the registrant is redirected to `otp.user_register_otp` at `/user/register/otp`. `OTPVerifyForm` (route `_access: 'TRUE'`) resolves the target user from the session uid, a `?u=<uuid>` query parameter, or (for the `administer site configuration` role) an explicit user id / email field, floods on `user_otp_submit`, rejects a code whose `md5()` does not match the stored value or that is older than 24 hours, and on success `activate()`s and `save()`s the user, deletes the stored code from `user.data`, and calls `user_login_finalize()` to log them in. `OTPResend::sendOtp()` (route `otp.user_register_otp_resend` at `/user/register/otp/resend/{uuid}`) and a "Resend" button re-issue a code. Admin settings live at `otp.settings` (`/admin/config/people/otp`); the shipped `config/install/otp.settings.yml` contains empty strings, so the module only behaves once an administrator saves the settings form, which populates the digit count, flood thresholds and email text.

---

- Verify a registrant's email with a typed numeric code instead of a click link.
- Keep the user on the site through the whole signup instead of sending them to their inbox to click a link.
- Reduce registrations abandoned at the "check your email and click" step.
- Avoid emailing a clickable activation credential that a mail scanner or link-preview bot can consume.
- Present an app-style "enter the code we sent you" verification screen at `/user/register/otp`.
- Configure code length from 1 to 10 digits (default 6) at `/admin/config/people/otp`.
- Customise the verification email subject and body with `[user:otp]` and `[user:otp_form_url]` tokens.
- Rate-limit how often a given email can request a code via `user_otp_generate_threshold` / `user_otp_generate_time_window`.
- Rate-limit verification attempts via `user_otp_submit_threshold` / `user_otp_submit_time_window`.
- Let a registrant resend a code from the verify form or via `/user/register/otp/resend/{uuid}`.
- Give an administrator (`administer site configuration`) a form to activate a pending account by user id or email.
- Provide a familiar OTP experience for a community or membership site's signup.
- Complete an email check within a single browser session on mobile or kiosk.
- Deep-link a user straight to their verification form with `[user:otp_form_url]` (`?u=<uuid>`).
- Replace core's link verification without writing custom code (the module swaps the flow on enable).
- Localise the code email per language through the standard mail/token pipeline.
- Add a lightweight friction step that discourages casual fake-account creation.
- Confirm an address before the account can log in (accounts stay blocked until the code is entered).
- Fall back to core link verification automatically on uninstall (`otp_uninstall()` re-enables `verify_mail`).
