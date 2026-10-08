<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email OTP Login (email_otp_login) — agent index

Passwordless login for existing Drupal accounts via a 6-digit one-time code emailed to the
account address. Package `User`. Depends only on core **`user`**. Core `^10.3 || ^11`.
License GPL-2.0-or-later. Version-dir 1.0.x (installed release 1.0.7).

- **The full login flow — routes, forms, OTP generation, storage, verification, mail, session
  finalize** → [flow/login.md](flow/login.md)

## What it actually is

- No config UI, no config objects/schema, no permissions of its own, no Drush, no submodules,
  no plugins. `dependencies: [drupal:user]` only.
- Two routes (`email_otp_login.routing.yml`):
  - `email_otp_login.email_form` — path `/otp-email`, form `OtpEmailForm`.
  - `email_otp_login.validate_otp` — path `/validate-otp/{email}`, form `OtpValidation`.
- Services (`email_otp_login.services.yml`):
  - `OtpGeneratorService` (alias `email_otp_login.generator`) — `generateOtp()` returns
    `random_int(100000, 999999)`.
  - `MailerService` (alias `email_otp_login.mailer`) — `sendOtpEmail()` sends via the mail
    manager, mail key `otp_email`.
  - `Hook\EmailOtpLoginHooks` — attribute `#[Hook('mail')]` building the `otp_email` subject/body;
    `email_otp_login.module` keeps a `#[LegacyHook]` `email_otp_login_mail()` shim.
- `src/Controller/OtpLoginController.php` (`generateOtp()`) exists as a service-container class but
  is **not wired to any route** in this release — the reachable flow is the two forms above.

## Login flow (from source)

1. `/otp-email` → `OtpEmailForm::submitForm()` loads the user by `mail`; if found and not blocked,
   generates a code, emails it, stores it in State as `otp_code_<email>`, and redirects to
   `email_otp_login.validate_otp` with the email as a route parameter.
2. `/validate-otp/{email}` → `OtpValidation::submitForm()` reads `otp_code_<email>` from State,
   compares with `hash_equals()`, and on a match calls `user_login_finalize($user)`, deletes the
   State entry, and redirects to the user's canonical profile.

Details, class/method citations, and the mail template are in [flow/login.md](flow/login.md).
