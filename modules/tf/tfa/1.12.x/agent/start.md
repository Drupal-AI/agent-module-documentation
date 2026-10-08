# tfa — agent start

Pluggable second-factor authentication. Interrupts a successful username/password login and
requires a code from an active **validation plugin** (ships TOTP `tfa_totp`, HOTP `tfa_hotp`,
recovery codes `tfa_recovery_code`; trusted-browser login plugin). Secrets are encrypted, so
TFA **requires** the `encrypt` module + an encryption profile (built on `key`). Config UI:
**Admin → Config → People → Two-factor Authentication** (`/admin/config/people/tfa`); settings
route `tfa.settings`.

- Enable TFA, choose allowed/default validation plugins, set encryption profile, require per role,
  user setup flow → [configure/tfa.md](configure/tfa.md)
- Plugin types (TfaValidation / TfaSetup / TfaLogin / TfaSend) and how to add one →
  [plugins/tfa.md](plugins/tfa.md)
- Permissions → [permissions/tfa.md](permissions/tfa.md)
