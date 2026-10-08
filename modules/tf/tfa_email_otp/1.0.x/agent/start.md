# TFA Email OTP — agent index

Adds an email one-time-password second factor to the contrib **tfa** module. Two plugins: a
`TfaValidation` plugin (`tfa_email_otp`) and its `TfaSetup` plugin (`tfa_email_otp_setup`).
Depends on `tfa` and `encrypt`. Config lives on the TFA settings page (`configure` =
`tfa.settings`). No permissions, no Drush. Provides config schema
(`tfa.validation.plugin.config.tfa_email_otp`). Defines no plugin types of its own.

- **Enable/allow the plugin, set validity period, customize the OTP email (tokens), where
  per-user + site config is stored** → [configure/settings.md](configure/settings.md)
- **The validation + setup plugin lifecycle: code generation/entropy, encryption, expiry,
  single-use/replay, flood control, `validateRequest()` for web services** →
  [plugins/tfa.md](plugins/tfa.md)

Key facts:
- Code = 8 numeric digits from `TfaRandomTrait::randomCharacters(8,'1234567890')` (uses
  `random_bytes` — cryptographically secure). Search space 10^8.
- Stored **encrypted** (Encrypt profile TFA is configured with) in `user.data`
  (`tfa`/`tfa_email_otp`: `code`, `expiry`, `enable`). Plaintext only in the email.
- Single-use: `validate()` clears `code`+`expiry` on success (`hash_equals` compare). Expired
  codes are cleared and rejected.
- Flood: sends capped 6/300s (`tfa_email_otp.send`); `validateRequest()` capped 6 failures/300s
  (`tfa_email_otp.validate_request`). Interactive form path defers brute-force lockout to TFA core.
