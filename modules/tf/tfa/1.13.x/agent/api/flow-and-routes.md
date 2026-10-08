<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login flow, routes, services & Drush

## Route override (how TFA inserts itself)

`Drupal\tfa\Routing\TfaRouteSubscriber` subscribes to `RoutingEvents::ALTER` at **`PHP_INT_MIN`**
(last) and rewrites core routes:

- `user.login` → `_form` = `TfaLoginForm`
- `user.login.http` → `_controller` = `TfaUserAuthenticationController::login`
- `user.reset.login` → `TfaUserController::resetPassLogin` (or `...ControllerDeprecated` on older
  core, chosen by reflecting the arg count of core `resetPassLogin`)
- `user.reset` → left as core `UserController::resetPass`

`tfa_requirements()` (runtime) reports an error if any of these overrides is missing (e.g. another
module overrode them later).

## Module-defined routes (`tfa.routing.yml`)

| Route | Path | Handler | Access |
|---|---|---|---|
| `tfa.settings` | `/admin/config/people/tfa` | `SettingsForm` | `_permission: admin tfa settings` |
| `tfa.overview` | `/user/{user}/security/tfa` | `TfaOverviewForm` | `_custom_access: TfaLoginController::accessSelfOrAdmin`, `_tfa_permission: setup own tfa` |
| `tfa.validation.setup` | `/user/{user}/security/tfa/{method}` | `TfaSetupForm` | same custom access, `_tfa_permission: setup own tfa` |
| `tfa.disable` | `/user/{user}/security/tfa/disable` | `TfaDisableForm` | same custom access, `_tfa_permission: disable own tfa` |
| `tfa.plugin.reset` | `/user/{user}/security/tfa/{method}/{reset}` | `TfaSetupForm` | same custom access, `_tfa_permission: setup own tfa` |
| `tfa.login` | `/tfa/login` | `TfaLoginForm` | `_user_is_logged_in: FALSE` |
| `tfa.entry` | `/tfa/{uid}/{hash}` | `EntryForm` | `_user_is_logged_in: FALSE`, `_custom_access: TfaLoginController::access`, `no_cache` |

Each user manages their own methods at `/user/{user}/security/tfa` (`TfaOverviewForm`), which lists
the allowed validation plugins with set-up / reset / disable links:

![Per-user TFA overview](../../../../../../../screenshots/tfa/1.13.x/user-overview.png)

## The second-factor flow

1. **`TfaLoginForm`** (extends core `UserLoginForm`) validates username/password. In `submitForm()`
   it migrates the session (anti-fixation), loads the user, and — via `TfaLoginContextTrait` —
   decides: `isTfaDisabled()` (global off, no default plugin, or user's roles don't require it) →
   normal login; `isReady()` (a validation plugin is configured) → `loginWithTfa()`; otherwise
   `canLoginWithoutTfa()` (skip allowance / flood messaging).
2. **`loginWithTfa()`**: if a login plugin allows it (trusted browser) the login is finalized;
   otherwise it stores the uid in the private tempstore (`tfaLoginContextTrait::tempStoreUid` →
   `tfa` collection, key `tfa-entry-uid`) and redirects to `tfa.entry` with `uid` +
   `hash` = `TfaLoginTrait::getLoginHash($user)` (an HMAC over account name + password hash + last
   login time, keyed by the site private key and hash salt).
3. **`TfaLoginController::access`** (guards `tfa.entry`): requires the tempstore `tfa-entry-uid` to
   equal the route uid (blocks starting the process for an arbitrary user), enforces a **5-minute**
   expiry on that tempstore entry, loads the user, and checks the login hash matches; if the caller
   is already authenticated it also runs `accessSelfOrAdmin`.
4. **`EntryForm`** renders the active validation plugin's form (with links to switch to other
   enabled methods), applies **flood control** (`tfa.failed_validation`, threshold/window from
   config, identifier = uid or uid+IP) plus a per-user lock around validation, then on success calls
   `user_login_finalize()`, runs plugin `finalize()` (e.g. sets the trusted-browser cookie), and
   clears the flood counter.

Password-reset one-time links follow the same idea in `TfaUserControllerBase::doResetPassLogin`:
core validates the link, then if TFA is ready the user is redirected to `tfa.entry` with a
`pass-reset-token` before the password can be changed (unless `reset_pass_skip_enabled` and uid 1).
`TfaUserAuthenticationController::login` refuses the JSON `user.login.http` endpoint for TFA-enabled
accounts (throws `AccessDeniedHttpException`) so REST logins cannot skip the second factor.

## Access-control helpers

`TfaLoginController::accessSelfOrAdmin` allows the target user (when they hold the route's
`_tfa_permission`) or a user with **`administer tfa for other users`**. For non-self access to a
specific `{method}`, it also consults the plugin's `allowUserSetupAccess()` (recovery codes deny
viewing another user's codes). `TfaOverviewForm::canPerformReset` lets an admin reset another user's
skip counter but not their own.

## Services (`tfa.services.yml`)

- `plugin.manager.tfa.validation` / `.setup` / `.login` / `.send` — the four plugin managers.
- `logger.channel.tfa` — dedicated logger.
- `tfa.route_subscriber` — the route override above.

Reusable traits: `TfaLoginContextTrait` (login decision logic; `@internal`), `TfaLoginTrait`
(`getLoginHash`), `TfaUserDataTrait` (read/write `tfa_user_settings` and other `tfa_*` keys in
`users_data`), `TfaRandomTrait` (CSPRNG strings/integers via `random_bytes` with rejection
sampling).

## Other integrations

- **Block** `tfa_user_login_block` (`TfaUserLoginBlock`, extends core `UserLoginBlock`) renders
  `TfaLoginForm`; `tfa_block_access()` forbids the core `user_login_block` while TFA is enabled.
- **Views field** `tfa_enabled_field` (`TfaEnabledField`) shows whether an account has TFA data.
- **hook_entity_operation** adds a *TFA* operation link to user rows (when `tfa.overview` access
  passes).

## Drush {#drush}

`drush.services.yml` registers two command services:

- **`tfa:reset-user`** (alias `tfa-reset-user`, `TfaCommands::resetUserTfaData` →
  `TfaTokenManagement`): reset one user's TFA by `--name`, `--uid`, or `--mail`; confirms, deletes
  all `tfa` `users_data` for that uid, logs it, and emails the disable notification.
- **`sql-sanitize` hook** (`TfaCommands::sanitize`): on `drush sql-sanitize` deletes every
  `users_data` row whose `name` starts with `tfa_`, stripping seeds/recovery codes from DB copies.
