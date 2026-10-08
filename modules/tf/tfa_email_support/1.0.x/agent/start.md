<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TFA Email Support (tfa_email_support) — agent index

**Adds an email one-time-password (OTP) second factor to the TFA module.**

- **Version:** 1.0.x (release 1.0.1)
- **Core:** ^10 || ^11 · package Security
- **Requires:** tfa
- **Plugins:** `TfaValidation` id `tfa_email_support` (login OTP, `src/Plugin/TfaValidation/Email.php`); `TfaSetup` id `tfa_email_support_setup` (enrolment, `src/Plugin/TfaSetup/EmailSetup.php`).
- **Route:** `/admin/config/people/tfa/email-templates` — `EmailTemplateSettingsForm`, perm `administer site configuration`.
- **Storage:** OTP in `state` (`tfa_email_support_otp_{uid}`, expiry + 120s resend cooldown); recipient in config `tfa.settings.user.{uid}` `data.tfa_email_support.email`. `hook_cron` purges expired OTPs.
- **Mail keys:** `send_otp`, `send_setup_otp`, `send_backup_codes` (`hook_mail`), templated with `@otp/@username/@ip_address/...`, optional HTML.
- **Security:** Admin route permission-gated; no anonymous/mutating endpoints beyond the TFA login flow. OTPs not logged (debug lines commented). `unserialize()` uses `allowed_classes => FALSE`.

See [configure/otp.md](configure/otp.md).
