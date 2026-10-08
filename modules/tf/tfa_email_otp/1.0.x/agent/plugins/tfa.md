# The TFA validation & setup plugins

This module implements two of the **tfa** module's plugin types (it defines none itself):

| Plugin id | Type | Class |
|---|---|---|
| `tfa_email_otp` | `@TfaValidation` (`setupPluginId = tfa_email_otp_setup`) | `Plugin/TfaValidation/TfaEmailOtpValidation` |
| `tfa_email_otp_setup` | `@TfaSetup` | `Plugin/TfaSetup/TfaEmailOtpSetup` (extends the validation class) |

Both extend `Drupal\tfa\Plugin\TfaBasePlugin` and use `TfaRandomTrait`. Per-user state lives in
`user.data` (`collection=tfa`, `name=tfa_email_otp`): keys `enable`, `code` (ciphertext),
`expiry` (unix ts).

## Setup plugin (`TfaEmailOtpSetup`)

- `getSetupForm()` — one required checkbox "Receive authentication one-time code by email",
  default from `user.data … enable`.
- `submitSetupForm()` — writes `enable` back to `user.data`.
- `getOverview()` — the account-page summary card + an "Enable Email OTP" link
  (`tfa.validation.setup` route). `validateSetupForm()` is a no-op (returns TRUE).

## Validation lifecycle (`TfaEmailOtpValidation`)

### `ready()`
Returns `(bool) user.data…['enable']` — only enabled users are challenged.

### `send()` — issue a code
1. `code = randomCharacters(8, '1234567890')` — 8 numeric digits. `TfaRandomTrait` builds this
   from `random_bytes(1)` per char (rejection-sampled), i.e. **cryptographically secure**.
   Search space 10^8.
2. `user.data['code'] = encryptService->encrypt($code, $encryptionProfile)` — stored
   **encrypted** (Encrypt module, the profile TFA is configured with). Plaintext code never
   persisted; it only goes into the email.
3. `user.data['expiry'] = now + validityPeriod`.
4. Emails the code via `mailManager->mail('tfa_email_otp', 'otp_email', …)`; `[code]`/`[length]`
   substituted first, then Drupal tokens (see [../configure/settings.md](../configure/settings.md)).

### `getForm()`
Renders the "Authentication code" textfield (`autocomplete=off`), a **Verify** submit (disabled
until a code exists, per `hasActiveOtp()`), and a **Send**/**Resend** button.

### `validate($code)` — check a code
- Loads `user.data`; returns FALSE if no `expiry`.
- If `now > expiry`: clears `code`+`expiry`, sets an "Expired" error, returns FALSE.
- Decrypts the stored code (catches `EncryptException` / `EncryptionMethodCanNotDecryptException`
  → logs, returns FALSE).
- Compares with **`hash_equals()`** (constant-time) after trimming spaces.
- On match: sets `isValid`, **deletes `code`+`expiry` from `user.data`** → the code is
  **single-use, no replay**.

### `validateForm()` — interactive login form
- If the op is **Send/Resend**: enforces send flood (`tfa_email_otp.send`, 6 per 300 s per uid),
  registers the attempt, calls `send()`, and returns FALSE with an empty error (so "code sent"
  is not shown as an error).
- Otherwise calls `validate()`; on failure sets "Invalid authentication code."
- Note: this form path does **not** itself register a flood event per wrong code; brute-force
  lockout on the interactive login is handled by the parent **tfa** module's own login-attempt
  controls. The dedicated rate limit below is on the web-services path.

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
expiry (1–10 min), send + web-services validation flood limits. The only brute-force gap on the
interactive form path is delegated to TFA core's global login lockout rather than enforced here.
