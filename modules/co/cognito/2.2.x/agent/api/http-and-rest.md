<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP login, REST resources & confirm/verify callbacks

## Routing (`cognito.routing.yml`)

| route | path | access | handler |
|-------|------|--------|---------|
| `cognito.login.http` | `POST /cognito/user/login` (`_format: json`) | `_user_is_logged_in: FALSE` | `Controller/CognitoAuthenticationController::login` |
| `cognito.confirm` | `/cognito/confirm/{base64_email}/{confirmation_code}` | `_user_is_logged_in: FALSE` | `Controller/ConfirmationController::confirm` |
| `cognito.verify_email_callback` | `/cognito/verify-email/{base64_email}/{confirmation_code}` | `_user_is_logged_in: TRUE` | `Controller/EmailVerificationController::verify` |
| `cognito.challenge.new_password` | `/user/cognito/new-password` | `_user_is_logged_in: FALSE` | `Form\Email\NewPasswordForm` |
| `cognito.verify_email` | `/user/cognito/verify-email` | `_user_is_logged_in: TRUE` | `Form\VerifyEmail` |
| `cognito.admin_settings` | `/admin/config/people/cognito/settings` | `_permission: administer cognito` | `Form\SettingsForm` |

REST resources are declared as `@RestResource` plugins (need the core REST/`rest_ui` config + their
own `restful …` permission per method/format to be reachable):

## HTTP JSON login — `CognitoAuthenticationController::login()`

Extends core `UserAuthenticationController`. Decodes JSON `{name, pass}`; 400 on missing fields.
Applies core **flood control** (`floodControl`, `user.http_login` + `user.failed_login_ip` windows)
and `userIsBlocked()`. Calls `cognito.aws->authorize()`; on failure registers flood events and
throws `BadRequestHttpException`. On success `externalauth->login($name,'cognito')`, stores auth
tokens, clears the flood counter, dispatches `cognito.logged_in`, and returns `{uid, name}` in the
requested format. Login is gated on Cognito verifying the password; flood control is present.

## `cognito_user_registration` — `POST /cognito/user/register`

`Plugin/rest/resource/CognitoUserRegistrationResource`. Serialization class `user`.
`post()` gates via `ensureAccountCanRegister()`: the account must be new, the **current user must be
anonymous** (authenticated users are told to use the core `user` REST resource), and
`user.settings:register` must not be `admin only`. It then `checkEditFieldAccess()`, `signUp()`s
the email/password against Cognito, and `externalauth->register(email,'cognito', …,
['cognito_uuid' => UserSub])`. If `auto_confirm_enabled`, it also `externalauth->login`s and mints
tokens. On `UsernameExistsException` it silently resends the confirmation code and returns the
"already exists" message. Returns `{registered_user:{uid}, redirect_url}`. Respects Drupal's
registration policy; only anonymous callers can use it.

## `cognito_auth_token` — `GET /cognito/auth-token`

`Plugin/rest/resource/CognitoAuthToken::get()` returns
`{idToken: cognito.token->getIdToken(), accessToken: cognito.token->getAccessToken()}`. The token
service is **current-user scoped** (`user.data` keyed by `current_user->id()`), so a caller only
ever receives **their own** Cognito tokens (used by SPA/mobile front-ends to obtain tokens for
calling other AWS resources). Reachability still requires the `restful get cognito_auth_token`
permission for the caller/format; anonymous callers have no stored tokens.

## Confirm callback — `ConfirmationController::confirm($base64_email, $confirmation_code)`

Anonymous route. `base64_decode`s the email (the email is an identifier, not a secret; the
**confirmation code emailed by Cognito is the secret**). Calls `cognito.aws->confirmSignup(email,
code)`; on error it flashes a warning and redirects to `user.login`. On success it
`externalauth->login(email,'cognito')` (completing registration), flashes the "registration
confirmed" message, and redirects (default `<front>`, overridable via
`cognito.account_confirmed_redirect`). This is a magic-link style confirm+login: possession of a
valid Cognito confirmation code for the email logs that account in. Brute-force resistance depends
on Cognito's own confirmation-code entropy/expiry and attempt limits (Cognito returns an error the
controller surfaces); there is no additional Drupal-side flood counter on this specific route.

## Verify-email callback — `EmailVerificationController::verify($base64_email, $confirmation_code)`

Authenticated route (`_user_is_logged_in: TRUE`). `base64_decode`s the email and calls
`cognito.aws->verifyUserAttribute('email', $code, cognito.token->getAccessToken())` — i.e. verifies
using the **logged-in user's own** stored access token. On success flashes a message and dispatches
`cognito.account_verified_redirect` + `cognito.email_verified`.
