<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TFA Email Support is a submodule-style plugin for the TFA (Two-Factor Authentication) module that adds an email one-time-password (OTP) second factor: a 6-digit code is emailed to the user at login and must be entered to complete authentication.
---
It ships a `TfaValidation` plugin (`tfa_email_support`) used at login and a `TfaSetup` plugin (`tfa_email_support_setup`) for the two-step enrolment (enter email -> verify code). OTPs are stored in Drupal `state` keyed by uid with an expiry, a 120-second resend cooldown, and are cleared on success and by a `hook_cron` cleanup. The recipient email is the per-user TFA email (config `tfa.settings.user.{uid}` `data.tfa_email_support.email`) falling back to the account email, and is masked in the UI. Emails are built in `hook_mail` (`send_otp`, `send_setup_otp`, `send_backup_codes`) from admin-editable subject/body templates with `@otp`, `@username`, `@site_name`, `@ip_address` etc. tokens, optional HTML templates and custom headers/reply-to. An admin form at `/admin/config/people/tfa/email-templates` (permission `administer site configuration`) edits the templates.

Notes for operators: per-attempt flood control is provided by the TFA base module, not here. Codes are stored in `state` with short expiries and are not logged (the debug log lines that would print OTPs are commented out). `unserialize()` in `ready()` correctly passes `allowed_classes => FALSE`. The single admin route is permission-gated; the module adds no anonymous or mutating endpoints beyond the TFA login flow it plugs into.
---
- Add an email OTP second factor to TFA logins.
- Let a user enrol email 2FA via the setup plugin (enter email, verify code).
- Send the login OTP to a per-user TFA email or the account email.
- Mask the recipient email address in the OTP form.
- Let users resend the OTP after a 120-second cooldown (AJAX timer).
- Customise the OTP email subject/body at the templates admin form.
- Customise the setup and backup-codes email templates.
- Use HTML email templates (`use_html_templates`) with a default styled layout.
- Insert dynamic tokens (`@otp`, `@username`, `@site_name`, `@ip_address`, `@date`).
- Add custom email headers, reply-to and X-Priority via config/`hook_mail_alter`.
- Restrict template editing to `administer site configuration`.
- Expire OTP codes automatically and clean them up on cron.
- Store the user's chosen TFA email in `tfa.settings.user.{uid}` config.
- Fall back to the account email when no TFA email is set.
- Preview a rendered email template (`tfa_email_support_preview_template`).
- Send an ad-hoc dynamic TFA email (`tfa_email_support_send_dynamic_email`).
- Check whether email TFA is ready for a uid (`tfa_email_support_is_ready`).
- Alter outgoing OTP messages via `hook_tfa_email_support_dynamic_mail_alter`.
