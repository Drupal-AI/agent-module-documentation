TFA Email OTP adds an "email one-time password" second factor to the TFA (Two-Factor Authentication) module: at login it emails the user an 8-digit numeric code that they enter to complete authentication. It ships a matching TFA validation plugin and setup plugin, plus a customizable OTP email template.

---

The module registers two TFA plugins that plug into the contrib `tfa` module's plugin types (it defines no plugin types of its own): a `TfaValidation` plugin `tfa_email_otp` (`TfaEmailOtpValidation`) and its `TfaSetup` plugin `tfa_email_otp_setup` (`TfaEmailOtpSetup`, which subclasses the validation plugin). A user enables it from their TFA setup page (a single "Receive authentication one-time code by email" checkbox stored in `user.data` under `tfa`/`tfa_email_otp`/`enable`). At login `send()` generates the code with the `tfa` module's cryptographically-secure `TfaRandomTrait::randomCharacters(8, '1234567890')` (from `random_bytes`), **encrypts it with the Encrypt module** using the profile TFA is configured with, and stores the ciphertext plus an `expiry` timestamp in `user.data`; the plaintext code is only ever put in the outgoing email. `validate()` decrypts the stored code, rejects it if past `expiry`, compares with `hash_equals()`, and on success **deletes the code and expiry** (single-use — no replay). Expiry is admin-configurable (1/2/3/4/5/10 minutes) at the TFA settings page (`tfa.settings`, the module's `configure` route) along with the OTP email subject/body template (tokens `[length]`, `[code]`, plus standard `[site:*]`/`[user:*]` tokens via `hook_mail`). Flood control caps OTP **sends** at 6 per 300 s per user and the web-services `validateRequest()` path at 6 failed validations per 300 s; the interactive login-form validation path relies on the parent TFA module's own login-attempt lockout. Requires `tfa` and `encrypt`. Provides config schema; no permissions, no Drush commands.

---

- Add email-based one-time codes as a second factor for site login (no authenticator app needed).
- Offer an email OTP fallback alongside TOTP/recovery-code TFA plugins.
- Let users self-enable email OTP from their TFA account setup page.
- Send a login code to the user's registered account email at each 2FA challenge.
- Customize the OTP email subject and body per site (with `[code]`, `[length]`, `[site:name]`, `[user:display-name]` tokens).
- Set how long a code stays valid (1, 2, 3, 4, 5, or 10 minutes) from the TFA settings page.
- Enforce single-use codes (the code is consumed and cleared on successful verification).
- Store the OTP encrypted at rest via the Encrypt module rather than in plaintext.
- Throttle OTP email requests to prevent email-bombing (6 sends per 5 minutes per user).
- Rate-limit programmatic OTP validation via `validateRequest()` (6 failed attempts per 5 minutes).
- Provide a "Send"/"Resend" button on the TFA login form to (re)issue a code.
- Integrate email OTP validation into a web-services / headless login flow via `validateRequest($code)`.
- Localize the OTP email to the user's preferred language (uses `getPreferredLangcode()`).
- Make email OTP the default TFA validation plugin site-wide.
- Migrate legacy `tfa_email_code` plugin data to `tfa_email_otp` automatically on install (`hook_install`).
- Require 2FA for privileged roles using email as the delivery channel.
- Give users without smartphones a working second factor.
- Auto-expire and clear stale codes when a new one is requested or the old one lapses.
- Disable the "Verify" button until a code has actually been sent.
- Combine with TFA's recovery codes so users locked out of email still have a fallback.
