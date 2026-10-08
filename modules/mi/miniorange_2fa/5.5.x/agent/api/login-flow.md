# The 2FA login flow

How miniOrange inserts a second factor into Drupal login, and how the flow is guarded. Source:
`MoRouteSubscriber`, `miniorange_2fa.module` (`hook_form_alter` + `miniorange_2fa_form_alter_submit`),
`MoAuthUtilities::invoke2faOrInlineRegistration`, `Form/MiniorangeAuthenticate`, `MoTfaController`,
`EventSubscriber/InitSubscriber`.

## Entry points that trigger 2FA

- **UI login forms** (`user_login_form`, `user_login_block`): `hook_form_alter` prepends
  `miniorange_2fa_form_alter_submit` (only when `mo_auth_enable_two_factor`, the customer is registered,
  not in maintenance mode, and the request IP is not trusted). After Drupal checks the password, the
  handler calls `MoAuthUtilities::invoke2faOrInlineRegistration($username, $destination, $form)`, which
  sets the `mo_auth` session and redirects to `/login/user/{user}/authenticate` — so core's
  `user_login_finalize()` never runs at this point.
- **REST login** (`user.login.http`): `MoRouteSubscriber` re-points the controller to
  `MoTfaController::validateLoginRequest`, which — when 2FA is enabled — throws `AccessDenied` instead of
  issuing a session (REST cannot complete the interactive second factor); when 2FA is off it defers to
  core `login()`.
- **Password reset** (`InitSubscriber` on `KernelEvents::REQUEST`): when
  `mo_auth_enable_2fa_for_password_reset` (or DRUPAL_2FA license) is on, the one-time-login URL is
  intercepted, the reset hash is re-verified with `user_pass_rehash()` + `hash_equals()`, and 2FA is
  invoked before the reset form is shown.

## The challenge step (`MiniorangeAuthenticate`, `/login/user/{user}/authenticate`)

The 2FA-flow routes (`authenticate`, `select_method`, `configure_method`, `configure-enduser-2fa`,
`password`) use `_access: 'TRUE'` — access is enforced inside the form by the **session guard**, not by a
permission:

- `buildForm()` requires session `mo_auth` to exist with `uid`, `status === '1ST_FACTOR_AUTHENTICATED'`,
  and an object `mo_challenge_response`; otherwise it wipes the session and redirects to login. It also
  checks the `{user}` URL segment equals `mo_auth['uid']`.
- `submitForm()` re-checks `mo_auth['uid'] == {user}` ("URL change detected" → abort), rejects an OTP
  already used within 5 minutes (`isOtpUsed` / `storeUserOtp`, hashed with `Crypt::hashBase64`), then
  calls `moCallValidateApi()` → `AuthenticationAPIHandler::validate()` against the **miniOrange cloud**
  (customer id + api key). Only on `response->status === 'SUCCESS'` does it run `user_login_finalize()`.
- Failed attempts decrement `allowedAttempts` and are logged; QR/push use `getAuthStatus()` polling;
  KBA/grid/hardware-token/passcode each map to the same validate call.

## Notes for agents

- OTP generation and verification are performed by the miniOrange cloud service, not locally — there is
  no local OTP secret to read on the Drupal side for the cloud methods.
- The `_access: TRUE` routes are safe because the session guard binds every step to the uid that just
  passed the first factor; the `{user}` URL param is validated against the session, so it cannot be used
  to authenticate as a different account.
- Recovery-code and device-removal routes use a custom access check
  (`Miniorange2faController::accessRoute`) that requires the current user (or an active recovery session)
  to match `{user}`.
- Basic-Auth API requests are separately gated by `TfaBasicAuthDecorator` (throws 401 when
  `mo_auth_2fa_for_apis` + `mo_auth_enable_two_factor` are on and the account requires 2FA).
