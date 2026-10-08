TFA adds a pluggable second step to Drupal login: after a correct username and password, the user must pass a second-factor challenge (TOTP authenticator app, HOTP, recovery codes, etc.) provided by a validation plugin.

---

TFA is a base module that interrupts a successful username/password authentication and hands form control to an active **validation plugin** before the user is fully logged in. It ships four plugin types — `TfaValidation` (verify a submitted code), `TfaSetup` (per-user enrollment for a validation method), `TfaLogin` (skip/allow the TFA step, e.g. trusted browser) and `TfaSend` (deliver a code) — each backed by a plugin manager. Out of the box it provides TOTP (`tfa_totp`), HOTP (`tfa_hotp`) and recovery-code (`tfa_recovery_code`) validation plugins plus a trusted-browser login plugin, generating QR codes for authenticator apps. Secrets (seeds, recovery codes) are stored encrypted, so TFA **requires** the `encrypt` module and an encryption profile (built on the `key` module) — it will not enable TFA until an encryption profile is selected. Admins configure it at **Admin → Configuration → People → Two-factor Authentication** (`tfa.settings`, `/admin/config/people/tfa`): enable TFA, pick allowed validation plugins and a default, choose the encryption profile, require TFA for chosen roles, and tune flood limits and how many times a user may log in before setup is enforced. Users enroll on their account's security tab (`/user/{uid}/security/tfa`), where they set up an authenticator, save recovery codes, and can disable methods. Flood control, per-role enforcement, a login block, and Drush commands for resetting/managing user TFA data round out the module.

---

- Add a second login step so a stolen password alone cannot access an account.
- Let users authenticate with a TOTP authenticator app (Google Authenticator, Authy, FreeOTP, etc.).
- Provide HOTP (counter-based) one-time passwords as an alternative to TOTP.
- Give users printable recovery codes to log in when their device is unavailable.
- Show a QR code during setup so users can scan an account into their authenticator app.
- Require TFA for specific roles (e.g. editors, admins) via `required_roles`.
- Choose which validation plugins are allowed and which is the default.
- Store TFA secrets encrypted using an Encrypt encryption profile (Key + Encrypt).
- Let a user mark a browser as trusted to skip the second step for a period (trusted-browser login plugin).
- Enforce that a required user completes setup within a limited number of grace logins (`validation_skip`).
- Redirect users who have not set up TFA straight to their setup page on login.
- Throttle repeated failed code attempts with configurable flood window and threshold.
- Send users an email when TFA is enabled or disabled on their account.
- Replace the core user login block with a TFA-aware login block.
- Allow a super administrator to skip TFA when resetting a password (`reset_pass_skip_enabled`).
- Let users disable their own configured TFA methods from the account security tab.
- Let administrators manage or reset TFA for other users.
- Add a custom validation plugin (e.g. SMS, WebAuthn, third-party service) by implementing `TfaValidationInterface`.
- Add a matching setup plugin so users can enroll in a custom validation method.
- Add a login plugin to grant conditional bypass of the TFA step.
- Reset a locked-out user's TFA data with the module's Drush commands.
- Customize the help text shown to users who cannot complete TFA.
- Prefix TOTP/HOTP QR labels with the site name for multi-site authenticator clarity.
- Adjust the TOTP time-skew / HOTP counter window to tolerate clock drift.
- Deploy TFA configuration between environments as exported config (`tfa.settings`).
- Disable TFA in dev/test environments via config so automated logins work.
