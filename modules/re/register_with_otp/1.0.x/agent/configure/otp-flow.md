<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# register_with_otp — OTP flow & operation

## Enabling
1. `drush en register_with_otp`.
2. Ensure a working mail transport (SMTP module or MTA) — the OTP is delivered only by email.
3. Ensure "Visitors can create accounts" is enabled in `admin/config/people/accounts` for the flow to be reachable by anonymous users.

## What the module changes
- `register_with_otp_entity_type_alter()` sets the user `register` form handler to `RegisterWithOtp`.
- For anonymous users the form gains a **Verify email** AJAX submit and a hidden **OTP** textfield (`#pattern` `[0-9]{5}`, maxlength 5). The final submit button is hidden until `otp_verified` is set.

## Runtime flow (`src/Form/RegisterWithOtp.php`)
1. `sendOtp()` (AJAX): validates the mail field, then `random_int(10000, 90000)` → `sendOtpMail()` emails it (`hook_mail` key `otp_mail_verification`, `#theme` `otp_validate`) and stores `otp`, `time`, `email`, `otp_verified=FALSE` in the session.
2. `validateForm()`: if `now - time <= 300`, compares submitted `otp` to the session `otp`; match → `otp_verified=TRUE`, mismatch → error. Past 300s → "expired", resets fields. Editing the email after verification forces re-verification.
3. `submitForm()`: for anonymous, `resetUserSession()` clears the OTP session keys, then core registration proceeds.

## Theming
- Override template `mail--otp-validate` (theme hook `otp_validate`, variable `values`) for the email body.
- CSS library `register_with_otp/validator_styles` (`css/validator-styles.css`).

## Notes
- The OTP is bound to the entered email and only sent there.
