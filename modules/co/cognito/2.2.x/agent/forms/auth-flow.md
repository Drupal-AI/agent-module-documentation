<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Overridden auth forms, flow plugin & route subscriber

Enabling the module rewires Drupal's own user forms to talk to Cognito. Two mechanisms do this, both
driven by the selected `CognitoFlow` plugin (`cognitoflow_email`, the only one — see
[config/settings.md](../config/settings.md)).

## Route subscriber — `Routing/RouteSubscriber::alterRoutes()`

Rewrites three core routes to Cognito form classes from the flow:

| core route | becomes |
|-----------|---------|
| `user.login` | `_form` → flow `login` = `Form\Email\UserLoginForm` |
| `user.pass` | `_form` → flow `password_reset` = `Form\Email\PassResetForm` |
| `user.admin_create` | `_entity_form` → `user.admin_register` |

## `hook_entity_type_alter` (`cognito.module`)

Swaps the `user` entity form handlers: `register` → flow `signup` (`RegisterForm`), `default` →
flow `profile` (`ProfileForm`), `admin_register` → flow `admin_signup` (`AdminRegisterForm`).

## The `Email` flow plugin

`Plugin/cognito/CognitoFlow/Email` (`@CognitoFlow(id="cognitoflow_email")`, extends
`CognitoFlowBase`). Maps form slots (`profile`, `signup`, `admin_signup`, `login`, `password_reset`)
to the classes above, and maps challenge `NEW_PASSWORD_REQUIRED` → route
`cognito.challenge.new_password`.

## Form classes (`Form/Email/*`, base `Form/CognitoAccountForm` extends core `AccountForm`)

- **`UserLoginForm`** (form id kept as `user_login_form`) — email + password. `validateAuthentication()`
  first checks local `user_is_blocked($mail)`, then `cognito.aws->authorize()`. On an `isChallenge()`
  result it redirects to the challenge route (e.g. new-password); on error it maps
  `PasswordResetRequiredException` to the configured message. On success `submitForm()` calls
  `externalauth->login($mail, 'cognito')` and stores the auth tokens. Login therefore happens
  **only after Cognito verifies the password**.
- **`RegisterForm`** (`cognito_register_form`) — multistep. `validateRegistration()` dispatches
  `CognitoEvents::REGISTER` (lets other modules add `UserAttributes`), `signUp()`s the user, then
  `externalauth->register($email,'cognito', … , ['cognito_uuid' => UserSub])` (unconfirmed). Then
  either: inline **confirmation-code** step (`validateConfirmation` → `confirmSignup`), **click-to-confirm**
  (email link → `ConfirmationController`), or **auto-confirm** (immediate `externalauth->login` +
  `authorize` to mint tokens) depending on `cognito.settings`. `validateForm()`/`save()` are
  intentionally no-ops (entity constraints and saving are handled by Cognito/externalauth). Password
  policy hint: 8+ chars, upper+lower+number (enforced by Cognito, not Drupal).
- **`AdminRegisterForm`** (`cognito_admin_register_form`) — email only; `adminSignup()`
  (`adminCreateUser`, emails a temporary password), then `externalauth->register(..., admin_registration)`.
  Reached via core `user.admin_create` (`administer users`).
- **`ProfileForm`** — user edit. `validateEmailChange()` requires the user's **current password**
  (unless they have `administer users`) and calls `adminUpdateUserAttributes` (which auto-sets
  `email_verified`). `validatePasswordChange()` requires current password, re-`authorize`s to prove
  it, then `changePassword`. `validateAccountStatus()` mirrors Drupal block/unblock to Cognito
  `adminDisableUser`/`adminEnableUser`. Username is kept in sync with email;
  `_skipProtectedUserFieldConstraint` is set because Cognito owns the password.
- **`NewPasswordForm`** (route `cognito.challenge.new_password`, `/user/cognito/new-password`,
  anonymous) — used after admin-create: email + temporary password + new password.
  `authorize()`s to obtain the `NEW_PASSWORD_REQUIRED` challenge `Session`, calls
  `adminRespondToNewPasswordChallenge`, then `changePassword`. Requires the emailed temporary
  password to proceed.
- **`PassResetForm`** (`cognito_email_password_reset`, replaces `user.pass`) — email →
  `forgotPassword()` (Cognito emails a code) → confirmation step (`confirmForgotPassword` with code
  + new password). Logs `Password reset for %email` (email only, no secret).
- **`VerifyEmail`** (route `cognito.verify_email`, `/user/cognito/verify-email`, authenticated) —
  requests an email-verification code for the logged-in user.

## Events

`Event/CognitoEvents` + `CognitoFormEvent` — `CognitoEvents::REGISTER` lets subscribers append
Cognito `UserAttributes` during registration. Several generic events are dispatched for redirect/UX
hooks: `cognito.logged_in`, `cognito.registered_logged_in`, `cognito.registered_click_to_confirm`,
`cognito.account_confirmed_redirect`, `cognito.account_verified_redirect`, `cognito.email_verified`.
