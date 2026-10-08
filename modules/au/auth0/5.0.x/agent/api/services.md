<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auth0 routes, flow & services

## Routes (`auth0.routing.yml`)

| Route | Path | Access | Handler |
|---|---|---|---|
| `auth0.login` | `/user/login` | `_access: TRUE` | `AuthController::login` → redirect to Auth0 |
| `auth0.legacy_login` | `/user/login/legacy` | `_access: TRUE` | core `UserLoginForm` (break-glass) |
| `auth0.callback` | `/auth0/callback` | `_access: TRUE` | `AuthController::callback` |
| `auth0.logout` | `/user/logout` | `_access: TRUE` | `AuthController::logout` |
| `auth0.password_reset` | `/auth0/password-reset` | `_user_is_logged_in: TRUE` | `PasswordResetController::requestPasswordReset` |
| `auth0.settings` / `auth0.advanced_settings` | `/admin/config/auth0[/advanced]` | `administer site configuration` | settings forms |

The public routes are intentionally `_access: TRUE` — a login callback must be reachable pre-auth.
Login CSRF / token integrity is enforced inside the SDK (see below), not by a Drupal access check.

## Login flow

1. **`/user/login`** → `AuthenticationService::handleLoginPage()` → `ClientService::loginUrl()` →
   `$client->login()` → `TrustedRedirectResponse` to Auth0's authorize endpoint (state + nonce issued
   into transient SessionStore).
2. User authenticates at Auth0 → redirected back to **`/auth0/callback`**.
3. `AuthenticationService::handleLogin()`:
   - `validateLogin()` throws on an `error` query param (`login_required` etc.).
   - `ClientService::exchange()` → `$client->exchange()`: the SDK **validates the `state` param**
     against transient storage (CSRF), exchanges the auth code, and **validates the ID token**
     (signature, `iss`, `aud`, `nonce`, expiry). Then `validateTokenSubject()` decodes the ID token
     and asserts its `sub` equals the userinfo `sub`. On any exception the SDK session is logged out
     and an `AuthenticationLoginException` is thrown.
   - `UserProvisionService::login()` loads/creates the Drupal user (see below), then redirects to `/user`.
4. **`/user/logout`** → `handleLogout()`: `user_logout()` then redirect to `$client->logout(returnTo)`
   (returnTo from `?returnTo`, default scheme+host).

## Services (`auth0.services.yml`)

| Service | Class | Role |
|---|---|---|
| `auth0.client` | `Service\ClientService` | Wraps the SDK `Auth0` client: `loginUrl`, `logoutUrl`, `exchange`, `requestPasswordReset`, `management`, transient store. Builds `SdkConfiguration` from `ConfigurationService`. |
| `auth0.configuration` | `Service\ConfigurationService` | Typed getters over `auth0.settings` + Key-module secret resolution + mapping parsing. |
| `auth0.authentication` | `Service\AuthenticationService` | Orchestrates login/callback/logout; `handleLogin/handleLogout/handleLoginPage`. |
| `auth0.user.provision` | `Service\UserProvisionService` | Maps Auth0 identity → Drupal user via `externalauth`. |
| `logger.channel.auth0` | logger channel | `auth0` log channel. |

## User provisioning (`UserProvisionService`)

- Keyed by ExternalAuth provider `auth0` and the Auth0 `sub` (`userId`).
- Existing user → `externalAuth->login()`, then optionally `syncAccountRoles()` /
  `syncAccountProfileFields()` (only when the relevant mapping + sync toggle are set), then save.
- New user → `externalAuth->register()` with name (from `auth0_username_claim`), email, mapped roles
  and mapped profile fields, then `userLoginFinalize()`.
- Role names from Auth0 are fetched via the Management API (`ClientService::getUserRoles`) and
  snake_cased. Protected fields (`uid,init,name,uuid,pass,roles,status`) are never overwritten by
  claim mapping.

## Password reset (`PasswordResetController`)

`/auth0/password-reset` (logged-in only): if `auth0_password_reset_enabled`, sends an Auth0
change-password email for the **current user's own** email via
`ClientService::requestPasswordReset()` (`dbConnectionsChangePassword` on the configured connection),
then redirects back to the user edit form with a status message. No arbitrary-email input.

## Value object

`ValueObject\Auth0User` — immutable holder of the userinfo array + refresh token; `get()`, `userId()`,
`email()`, `roles()` accessors used by provisioning.
