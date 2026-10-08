<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API User Resources (jsonapi_user_resources) — agent index

Adds three account endpoints to JSON:API that core deliberately omits — anonymous
**registration**, **password-reset request**, and **one-time-login password update**. Built on
**`jsonapi_resources`** (non-entity JSON:API resources), not a REST controller. Requires core
`jsonapi` + contrib `jsonapi_resources`. Version **8.x-1.0-beta2** — **beta**. Core `^10.1 || ^11`.

Routes are registered from `Routes::routes()` (a `route_callbacks` entry in
`jsonapi_user_resources.routing.yml`), **not** a static routing file. `Routes::routes()` prefixes
every path with `/%jsonapi%` (the JSON:API base path, default `/jsonapi`) **and adds one shared
requirement to all three: `_user_is_logged_in: 'FALSE'`** — every endpoint is anonymous-only; an
authenticated session gets a 403.

## The three endpoints

| Route name | Method | Path | Resource class |
|---|---|---|---|
| `jsonapi_user_resources.registration` | POST | `/jsonapi/user/register` | `src/Resource/Registration.php` |
| `jsonapi_user_resources.password_reset` | POST | `/jsonapi/user/password/reset` | `src/Resource/PasswordReset.php` |
| `jsonapi_user_resources.password_update` | PATCH | `/jsonapi/user/{user}/password/update` | `src/Resource/PasswordUpdate.php` |

- **Registration** (`Registration`, uses `EntityCreationTrait`): maps the body to a new `user--user`
  entity. `ensureAccountCanRegister()` rejects a client-set ID, requires an anonymous caller, and
  throws 403 when `user.settings.register` is `admin_only`. `modifyCreatedEntity()` then forces the
  status: `activate()` only when `register == visitors` **and** `verify_mail` is off, otherwise
  `block()`. Requires a password when `verify_mail` is off; forbids one when it is on. Returns 201
  with the new user resource. Dispatches `REGISTRATION_VALIDATE` (pre-save) and
  `REGISTRATION_COMPLETE` (post-save); `UserRegistrationSubscriber` sends the approval email.
- **PasswordReset** (`PasswordReset`): declares an inline `user--password-reset` resource type with
  `name` + `mail` attributes. Loads the account by `name`, else by `mail`. Dispatches
  `PASSWORD_RESET`; `PasswordResetSubscriber` sends the core `password_reset` email. Returns **202**.
- **PasswordUpdate** (`PasswordUpdate`): body must carry `timestamp`, `hash`, `pass`. Validates with
  the same expression core uses for one-time-login (`hash_equals($hash, user_pass_rehash($user,
  $timestamp))` plus timeout and last-login checks), then sets the password and activates a blocked,
  never-logged-in account when `verify_mail` is on. Returns the updated user resource.

## Events (extension point)

`Events\UserResourcesEvents`: `REGISTRATION_VALIDATE`, `REGISTRATION_COMPLETE`, `PASSWORD_RESET`.
Each carries the `UserInterface` and the JSON:API request document. Services are wired in
`jsonapi_user_resources.services.yml`. See `agent/api/endpoints.md` for request/response shapes,
payload fields, and integration notes.

## Optional hypermedia

With `jsonapi_hypermedia` installed (a dev/optional dependency), the
`AuthenticatedAsLinkProvider` plugin adds an `authenticated-as` top-level link to the current
user's `jsonapi.user--user.individual` resource for authenticated requests.

## Notes

- No permissions, no Drush commands, no config schema, no submodules. Access is governed entirely by
  the anonymous-only route requirement plus `user.settings` (`register`, `verify_mail`,
  `password_reset_timeout`).
- The user password can also be changed through core's `/jsonapi/user/user/{user}` — this module is
  additive for the parts an anonymous client cannot otherwise reach.
