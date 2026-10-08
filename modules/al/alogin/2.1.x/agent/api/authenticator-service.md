<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# alogin.authenticator service, login/enrol flow, forms & REST override

## Install & enable

```bash
composer require drupal/alogin   # pulls pragmarx/google2fa-qrcode + bacon/bacon-qr-code
drush en alogin -y
```

No Drupal module dependencies. `hook_schema()` in `alogin.install` creates the
`alogin_user_settings` table (`uid` PK, `secret` varchar_ascii 255, `enabled` int).

## The service — `Drupal\alogin\AuthenticatorService` (`src/AuthenticatorService.php`)

Service id `alogin.authenticator`; constructor args `@config.factory`, `@tempstore.private`,
`@current_user`, `@database`. It instantiates `PragmaRX\Google2FAQRCode\Google2FA` and resolves the
"current uid" as `currentUser->id()` when authenticated, otherwise the `uid` stashed in the
`alogin` private tempstore (the mid-login case). On construction, if the resolved uid has no stored
secret and none is in the tempstore, it generates one with `generateSecretKey(64)` and stashes it
in the tempstore until enrolment is saved.

Methods:

- `getQr()` — `Google2FA::getQRCodeInline(issuer, displayName, secret)`; issuer is the
  `system.site` name (spaces stripped). Returns an inline SVG or `data:image/png` string.
- `check($code)` — `Google2FA::verifyKey($this->secret, $code)` for the current uid's secret.
- `verifyCode($code, $uid)` — same, for an explicit uid (used by the REST controller).
- `store($enable)` — insert (`new`) or `update` the user's row; disabling blanks the secret.
- `exists($uid = NULL)` / `isEnabled($uid)` / `getSecret($uid)` — table lookups on
  `alogin_user_settings`. All queries use the DB API with parameterised `condition()`.

## Enrolment — `SettingsForm` at `/user/{user}/2fa` (`src/Form/SettingsForm.php`)

Route `alogin.settings`; access via `AuthenticatorController::access()` (see below). Form id
`settings_form`. Shows the QR (`getQr()`) inside `.qr-frame`; a `data:image/png` value is wrapped
with `FormattableMarkup` (`:src` placeholder, escaped), otherwise the SVG string via
`Markup::create()`. A "Code" textfield confirms the secret. If `allow_enable_disable` is on, an
"Enable 2FA" checkbox appears (default from the stored `enabled` flag). `validateForm()` calls
`aloginAuthenticator->check($code)` when enabling; `submitForm()` calls `store($enable)`
(`$enable = 1` when the toggle is hidden, i.e. 2FA is mandatory) and clears the tempstore secret.
A local task tab "Enable 2FA" (`alogin.links.task.yml`) is added to the user canonical route.

## Login-time verification — the web flow

1. `alogin_form_alter()` (`alogin.module`): for `user_login_form`, sets `#cache max-age 0`,
   `unset($form['#submit'][0])`, and attaches AJAX callback `alogin_ajax_callback` on the submit
   button. Core's own validation handlers still run (name/pass/flood → `uid` in form state).
2. `alogin_ajax_callback()`: if `$form_state->getErrors()` or no `uid` (bad password), it re-renders
   the form with status messages. Otherwise it loads the account, stores `uid` in the `alogin`
   private tempstore, and:
   - if `authenticator->isEnabled(uid)` → `RedirectCommand` to `alogin.two_fa_form` (**does not**
     finalise the session yet);
   - else → `user_login_finalize($account)` and redirect to `user.page`.
3. `TwoFaForm` at `/2fa` (`src/Form/TwoFaForm.php`, route `alogin.two_fa_form`, `_access: 'TRUE'`):
   form id `two_fa_form`, a "Code" field + AJAX "Login" button. `validateForm()` →
   `authenticator->check($code)`; on success `loginCallback()` does
   `user_login_finalize(User::load($tempstore uid))`, deletes the tempstore `secret`/`uid`, and
   redirects to `user.page`. The route is `_access: 'TRUE'` because the visitor is not yet
   authenticated at this step; the tempstore is a **private** store keyed to the session, so the
   uid it finalises is the one placed there by that same session's password step.

## REST/JSON login — `MfaLoginController` (`src/Controller/MfaLoginController.php`)

`Routing\AloginRouteSubscriber::alterRoutes()` repoints the core `user.login.http` route
(`POST /user/login?_format=json`, available when `serialization`/REST user login is enabled) to
`MfaLoginController::validateLoginRequest()`. The controller extends core
`UserAuthenticationController`. It decodes `{name, pass, mfa_token}`, loads the user, and:

- if the account **has** a stored 2FA row, requires a non-empty `mfa_token` and validates it with
  `authenticatorService->verifyCode($mfa_token, uid)` before delegating to `parent::login()`;
- otherwise it falls through to normal login.

## Access control — `AuthenticatorController::access()` (`src/Controller/AuthenticatorController.php`)

Custom access for `alogin.settings`: `AccessResult::allowedIf($account->isAuthenticated() &&
$routeUserId === $account->id())`, where `$routeUserId` is the `{user}` route parameter's id — so a
user reaches only their own settings form (admins reach the config form via `administer alogin`).

## Drush — `mfa-reset {uid}` (`src/Commands/MfaReset.php`)

Command `mfa-reset` (alias `mfar`), service `alogin.commands` (arg `@database`). Deletes the user's
row from `alogin_user_settings` if present, printing a confirmation; used to clear a locked-out
user's 2FA (`drush mfa-reset 1`).
