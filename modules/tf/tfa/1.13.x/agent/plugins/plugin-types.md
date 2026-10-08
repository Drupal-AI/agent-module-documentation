<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TFA plugin types and built-in plugins

TFA defines **four** plugin types, each with an annotation, an interface, and a manager service.
All managers extend `DefaultPluginManager`; the validation, login, and setup managers inject
`user.data`, the Encrypt profile manager, and the `encryption` service and pass them to each
plugin's `create()`/constructor.

| Type | Annotation | Interface | Manager service (class) | Subdir |
|---|---|---|---|---|
| Validation | `@TfaValidation` | `TfaValidationInterface` | `plugin.manager.tfa.validation` (`TfaValidationPluginManager`) | `Plugin/TfaValidation` |
| Setup | `@TfaSetup` | `TfaSetupInterface` | `plugin.manager.tfa.setup` (`TfaSetupPluginManager`) | `Plugin/TfaSetup` |
| Login | `@TfaLogin` | `TfaLoginInterface` | `plugin.manager.tfa.login` (`TfaLoginPluginManager`) | `Plugin/TfaLogin` |
| Send | `@TfaSend` | `TfaSendInterface` | `plugin.manager.tfa.send` (`TfaSendPluginManager`) | `Plugin/TfaSend` |

Every validation/login plugin extends **`TfaBasePlugin`** (`src/Plugin/TfaBasePlugin.php`), which
holds the shared `encrypt()`/`decrypt()` (via the profile in `tfa.settings.encryption`), the
constant-time `validate()` (`hash_equals`), and replay protection: `storeAcceptedCode()` records
`Crypt::hashBase64($code)` in `users_data` and `alreadyAcceptedCode()` checks it (including against
historical `hash_salt` values in `Settings::get('tfa.previous_hash_salts')`). A validation plugin
declares its paired setup plugin via the annotation `setupPluginId` (the managers fall back to
`<id>_setup` for legacy plugins).

## Built-in validation plugins

- **`tfa_totp`** — `TfaTotpValidation`. Time-based OTP using `christian-riesen/otp`
  (`checkHotpResync`). `getSeed()` base64-decodes then decrypts the per-user seed from
  `users_data` key `tfa_totp_seed`; `ready()` is true only when a seed exists. Enforces a
  monotonically increasing `tfa_totp_time_window` so a code cannot be reused within its skew window.
- **`tfa_hotp`** — `TfaHotpValidation`. Counter-based OTP; seed at `tfa_hotp_seed`, counter at
  `tfa_hotp_counter` (incremented on success), look-ahead = `counter_window`.
- **`tfa_recovery_code`** — `TfaRecoveryCode`. One-time codes stored (each encrypted) under
  `tfa_recovery_code`. `validate()` acquires a per-user lock, compares with `hash_equals`, and on a
  match **removes** the used code and re-stores the remainder. `generateCodes()` makes
  `recovery_codes_amount` random 9-digit codes; `ready()` is true when unused codes remain.
  `allowUserSetupAccess()` prevents even admins from viewing another user's codes.

## Built-in setup plugins

`tfa_totp_setup`, `tfa_hotp_setup`, `tfa_recovery_code_setup`, `tfa_trusted_browser_setup` each
extend their validation counterpart and implement `TfaSetupInterface` (`getSetupForm`,
`validateSetupForm`, `submitSetupForm`, `getOverview`, `getHelpLinks`, `getSetupMessages`).
`TfaTotpSetup` generates a fresh seed (`GoogleAuthenticator::generateRandom()`), renders an
`otpauth://totp/...` QR image with `chillerlan/php-qrcode`, verifies a code, then encrypts and
stores the seed (`storeSeed`). `TfaRecoveryCodeSetup` generates and displays codes (grouped
`XXX XXX XXX`) for the user to save. The `TfaSetup` wrapper (`src/TfaSetup.php`) delegates
begin/getForm/validate/submit to the active setup plugin, driven by `TfaSetupForm`.

## Built-in login plugin

- **`tfa_trusted_browser`** — `TfaTrustedBrowser` (implements both `TfaLoginInterface` and
  `TfaValidationInterface`). `loginAllowed()` returns TRUE when the request carries a valid
  `tfa-trusted-browser` cookie whose value matches a server-stored id in `users_data`
  (`tfa_trusted_browser`). `setTrusted()` mints a 256-bit random id
  (`base64(random_bytes(32))`), records it with created time / client IP / browser name, and issues
  an `httponly` cookie (secure flag from `session.cookie_secure`) valid for `cookie_expiration`
  days. If any enabled login plugin allows login, the second-factor form is skipped
  (`TfaLoginContextTrait::pluginAllowsLogin`).

## Implementing your own plugin

Create a class in your module under the matching `Plugin/Tfa*` namespace with the right annotation
and interface. Validation/login plugins get `($config, $id, $def, UserDataInterface,
EncryptionProfileManagerInterface, EncryptServiceInterface)` from the manager; use
`ContainerFactoryPluginInterface::create()` to add more services (as the built-ins do for
`config.factory`, `datetime.time`, `lock`, `current_user`). Alter hooks: `tfa_validation`,
`tfa_login_info`, `tfa_send_info`. Register the plugin as *allowed* on the settings form so users
can enable it. Send plugins (SMS/email delivery) are discovered from `Plugin/TfaSend`; none ship
in core TFA.
