# Registration Verification: settings & flow

## Settings (`registration_verification.settings`)

Form `RegistrationVerificationForm` at
`/admin/config/people/miniorange_2fa/registration-verification` (route
`registration_verification.settings`, permission `administer site configuration`).

| Key | Meaning |
|---|---|
| `enable` | Master switch (default off). When off, only a "suppress mail error" submit tweak is added. |
| `verification_method` | `email`, `phone`, or `email_phone`. |
| `phone_field` | Machine name of the phone field to require (default `registration_phone`; a `tel` field is injected if missing). |
| `redirect_after_registration` | URL to redirect to after successful verification (falls back to `user.page`). |

## Flow

1. `registration_verification_form_user_register_form_alter()` — for non-`administer users` visitors and
   when `enable` is on — makes the phone field required (for phone/email_phone), attaches a country-flag
   dropdown, replaces the submit handlers, and adds `registration_verification_user_register_handler` as a
   validation handler.
2. `registration_verification_user_register_handler()` validates the phone (`/^\+\d{6,15}$/`), then
   creates the user **blocked** (`status = 0`), stores `{uid, name, email, phone, verification_method,
   timestamp}` in the session (`OtpService::setSessionData`), calls `MoAuthUtilities::moCreateUser()`, and
   sends the OTP (`registration_verification_send_otp` → `OtpService::sendOtp` →
   `AuthenticationAPIHandler::challenge`). On success it redirects to `registration_verification.verify`;
   on failure it deletes the just-created account.
3. `OtpVerificationForm` (`/user/register/verify`, route `registration_verification.verify`,
   `_access: TRUE`) — guarded by `OtpService::isSessionValid()` (30-min TTL). Validates the OTP format,
   then `OtpService::validateOtp()` (cloud `validate`). On success: loads the pending user,
   `$user->activate()`, `$user->save()`, `user_login_finalize()`, clears the session, and redirects.
   "Resend OTP" re-challenges. An expired/invalid session deletes the pending blocked user.

## Notes for agents

- OTP generation and validation are performed by the **miniOrange cloud** (parent module's
  `AuthenticationAPIHandler`), not locally — there is no local OTP secret.
- The verify route is open (`_access: TRUE`) but is bound to the session's pending registration; the code
  cannot be used to activate an arbitrary account (the uid comes from the session, and the account is
  created blocked until the matching OTP succeeds).
- `OtpService` (service id `registration_verification.otp_service`) also exposes session helpers
  (`getSessionData`, `updateSessionData`, `clearSessionData`, `isSessionValid`) and the
  `AUTH_METHOD_MAP` (`email`→EMAIL, `phone`→SMS, `email_phone`→"SMS AND EMAIL").
