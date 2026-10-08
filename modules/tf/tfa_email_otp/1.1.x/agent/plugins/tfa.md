# The TFA validation & setup plugins

This module implements two of the **tfa** module's plugin types (it defines none itself):

| Plugin id | Type | Class |
|---|---|---|
| `tfa_email_otp` | `@TfaValidation` (`setupPluginId = tfa_email_otp_setup`) | `Plugin/TfaValidation/TfaEmailOtpValidation` |
| `tfa_email_otp_setup` | `@TfaSetup` | `Plugin/TfaSetup/TfaEmailOtpSetup` (extends the validation class) |

Both extend `Drupal\tfa\Plugin\TfaBasePlugin` and use `TfaRandomTrait`. Per-user state lives in
`user.data` (`collection=tfa`, `name=tfa_email_otp`): keys `enable`, `code` (ciphertext),
`expiry` (unix ts).

The validation plugin's constructor injects `user.data`, the Encrypt profile manager +
encryption service, config factory, logger factory, mail manager, time, flood, the
**email validator**, the **entity type manager**, and the **messenger** (the last three added in
1.1.x — see the diff below).

## Setup plugin (`TfaEmailOtpSetup`)

- `getSetupForm()` — first checks `accountHasValidEmail()`; if the account has no valid email it
  renders only a message + link to the user edit form and returns (no enable checkbox). Otherwise
  it shows one required checkbox "Enable two-factor authentication via email", default from
  `user.data … enable`, plus a Save button.
- `validateSetupForm()` — returns FALSE with an error if the account still has no valid email;
  otherwise TRUE.
- `submitSetupForm()` — writes `enable` back to `user.data`.
- `getOverview()` — the account-page summary card + an "Enable Email OTP" link
  (`tfa.validation.setup` route).

## Validation lifecycle (`TfaEmailOtpValidation`)

### `ready()`
Returns `(bool) user.data…['enable']` — only enabled users are challenged.

### `send()` — issue a code
1. Loads the recipient user via the injected `entityTypeManager`. If the user no longer exists it
   **logs an error and returns without generating or storing a code** (1.1.x guard).
2. `code = randomCharacters(8, '1234567890')` — 8 numeric digits. `TfaRandomTrait` builds this
   from `random_bytes(1)` per char (rejection-sampled), i.e. **cryptographically secure**.
   Search space 10^8.
3. `user.data['code'] = encryptService->encrypt($code, $encryptionProfile)` — stored
   **encrypted** (Encrypt module, the profile TFA is configured with). Plaintext code never
   persisted; it only goes into the email.
4. `user.data['expiry'] = now + validityPeriod`.
5. Emails the code via `mailManager->mail('tfa_email_otp', 'otp_email', …)` in the recipient's
   `getPreferredLangcode()`; `[code]`/`[length]` substituted first, then Drupal tokens (see
   [../configure/settings.md](../configure/settings.md)). On success a "code sent" message is
   shown via the injected messenger; on mail failure it logs an error.

### `getForm()`
- Loads the recipient and shows their **masked** email (e.g. `j***e@example.com`) via
  `maskEmail()` (local part reduced to first + `***` + last, domain shown in full).
- Renders the "Authentication code" textfield (`autocomplete=off`) whose `#access` is gated on a
  code already having been sent (`hasActiveOtp()`), plus a validity-period description
  ("Codes are valid for N minutes.").
- **Verify** submit is disabled until a code exists; a **Send**/**Resend** button issues/re-issues
  a code.

### `hasActiveOtp()`
Returns TRUE only when `code` + `expiry` are present and not past. If expired it clears them and
returns FALSE (drives whether the code field/Verify button are active).

### `validate($code)` — check a code
- Trims spaces; loads `user.data`; returns FALSE if no `expiry`.
- If `now > expiry`: clears `code`+`expiry`, sets an "Expired" error, returns FALSE.
- Decrypts the stored code (catches `EncryptException` / `EncryptionMethodCanNotDecryptException`
  → logs, returns FALSE).
- Compares with **`hash_equals()`** (constant-time) after trimming spaces from the stored value.
- On match: sets `isValid`, **deletes `code`+`expiry` from `user.data`** → the code is
  **single-use, no replay**.

### `validateForm()` — interactive login form
- If the op is **Send/Resend**: enforces send flood (`tfa_email_otp.send`, 6 per 300 s per uid),
  registers the attempt, calls `send()`, and returns FALSE with an empty error (so "code sent"
  is not shown as an error).
- Otherwise calls `validate()`; on failure sets "Invalid authentication code."
- Note: this form path does **not** itself register a flood event per wrong code; brute-force
  lockout on the interactive login is handled by the parent **tfa** module's `EntryForm`
  (`tfa.failed_validation`, default threshold 6 / window 300 s). The dedicated rate limit below is
  on the web-services path.

## Web-services entry point: `validateRequest($code)`
For headless/REST login. Wraps `validate()` with its own flood control
(`tfa_email_otp.validate_request`, threshold 6 / window 300 s, per-uid identifier):
- Denies immediately (returns FALSE) if the flood threshold is exceeded.
- On failure, registers a flood event.
- On success, clears both the validate and send flood counters.

## Flood constants (class consts)
`EMAIL_TFA_OTP_LENGTH=8`, `EMAIL_SEND_FLOOD_THRESHOLD=6` / `EMAIL_SEND_FLOOD_WINDOW=300`,
`VALIDATE_REQUEST_FLOOD_THRESHOLD=6` / `VALIDATE_REQUEST_FLOOD_WINDOW=300`.

## Security properties (summary)
Secure RNG (10^8 space), encrypted at rest, constant-time compare, single-use, admin-bounded
expiry (1–10 min), send + web-services validation flood limits, and interactive-form brute-force
lockout via TFA core's `tfa.failed_validation` flood.

## Diff 1.0.x → 1.1.x

Behavioural / API changes in the 1.1.0 release (per the module changelog and source):

- **Setup requires a valid email.** `TfaEmailOtpSetup` now checks `accountHasValidEmail()`; the
  enable checkbox is only offered when the account has a valid address, and `validateSetupForm()`
  re-checks on submit.
- **Clearer entry form.** The TFA challenge form shows the **masked** recipient email
  (`maskEmail()`), keeps the code field hidden (`#access`) until a code has been sent, and states
  the validity period ("Codes are valid for N minutes.").
- **Constructor signature changed** — `TfaEmailOtpValidation::__construct()` gained
  `EmailValidatorInterface`, `EntityTypeManagerInterface`, and `MessengerInterface` parameters.
  Custom subclasses must be updated.
- **No more static calls.** The plugin no longer calls `User::load()` or `\Drupal::messenger()`
  statically; the entity type manager and messenger are injected (behaviour otherwise unchanged).
- **Preferred-language mail.** OTP emails are now dispatched with the recipient's
  `getPreferredLangcode()` instead of `NULL`, fixing a fatal error with mailers that type-hint the
  langcode (e.g. Symfony Mailer / Mailer Plus) and aligning token replacement with `hook_mail()`.
- **Missing-account guard.** `send()` bails out (logging an error) if the user no longer exists,
  instead of raising a fatal error; no code is generated or stored for a missing account.
