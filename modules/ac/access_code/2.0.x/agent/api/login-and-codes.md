<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login flows, routes, service API & storage

All class references are under `web/modules/contrib/access_code/`.

## Routes (`access_code.routing.yml`)

| Route | Path | Handler | Requirement |
|-------|------|---------|-------------|
| `access_code.login` | `/user/ac` | `_form: Form\LoginForm` | `_user_is_logged_in: 'FALSE'` |
| `access_code.auto_login` | `/ac/{access_code}` | `Controller\UseCodeController::useCode` | `_user_is_logged_in: 'FALSE'` |
| `access_code.settings` | `/admin/config/people/access_code` | `_form: Form\SettingsForm` | `_permission: 'administer account settings'` |

Both login routes are only reachable by anonymous (logged-out) visitors.

## Permissions (`access_code.permissions.yml`)

- `change own access code` — a user may manage the access code on *their own* account form.
- `change any access code` — may manage codes on *any* account form.
- Core `administer users` also grants access to the fields and is the only permission that lets an
  admin **type an explicit code** (`$can_pick_code` in `AccessCodeManager::addFormFields`); users
  with only the two permissions above can regenerate a *random* code but the text field is disabled.

## Login form — `Form\LoginForm`

Service-built (`user.flood_control`, `access_code.manager`, `config.factory`, `module_handler`).
`buildForm()` renders one field `access_code` — a `password` field, or a `textfield` when the
`display_input` config flag is on — `#maxlength` 20, `#required`. Being a `FormBase`, it carries
Drupal's automatic form CSRF token.

`validateForm()`:
1. Checks core flood: `userFloodControl->isAllowed('user.failed_login_ip', ip_limit, ip_window)`
   (limits from the core `user.flood` config). If blocked, sets an error and stops.
2. Calls `accessCodeManager->validateAccessCode($value)`. On failure it **registers** a
   `user.failed_login_ip` flood event and shows "Invalid access code."; on success stores the uid.

`submitForm()` loads the user, calls `AccessCodeManager::processLogin()` and redirects to the
returned `Url`.

## Auto-login link — `Controller\UseCodeController::useCode($access_code, Request)`

Same shape as the form path but for the `/ac/{access_code}` GET link: checks
`user.failed_login_ip` flood first (throws `AccessDeniedHttpException` if exceeded), validates the
code, and on success redirects to `processLogin()`'s `Url`; on failure it registers a flood event
and throws `AccessDeniedHttpException`.

## Service — `Service\AccessCodeManager` (`access_code.manager`)

- `validateAccessCode($code)` — parameterized `SELECT` on the `access_code` table by `code`
  (`->condition('code', $code)`). Returns `FALSE` if no row, if `expiration` is set and in the past,
  if the user cannot load, if the account is inactive, or if the account has a role listed in the
  `blocked_roles` config; otherwise returns the matching **uid**.
- `getAccessCode($uid)` — returns `['code','expiration']` for a user, or `NULL`.
- `checkUniqueCode($code, $uid = NULL)` — TRUE unless the code is already assigned to a *different*
  user; used by validation and by generation.
- `generateRandomCode($length, $format, $prefix)` — builds a code from the configured
  length/format/prefix (defaults 8 / `alpha` / ''), min length 4, retrying up to 10 times until
  `checkUniqueCode()` passes; logs an error and returns `NULL` if it cannot.
- `updateAccessCode(User, $code, $expiration)` — `MERGE`s the row (`code`, `expiration` stored as a
  Unix timestamp via `strtotime`, `0` if none) keyed on `uid`; deletes the row when `$code` is empty.
- `processLogin(User)` — calls core `user_login_finalize($user)` (real authenticated session), adds
  a status message, then resolves the redirect: first any `Url` returned by
  `hook_access_code_login_redirect($user)` (invoked via `moduleHandler->invokeAll`), else the
  `destination` query param, else the user's canonical page.
- `addFormFields(&$form, $form_state)` — injects the *Access code* fieldset (code textfield,
  Generate-random AJAX button, expiration date, current access link) into the user register/edit
  forms, gated by the permission logic above; registers `validateFormFields` / `submitFormFields`.
- `validateFormFields()` (static) — enforces alphanumeric only, ≤ 20 chars, ≥ 4 chars when set,
  future expiration, no expiry beyond year 2037 (timestamp overflow), and uniqueness.

## User-form integration & hooks (`access_code.module`)

- `hook_form_user_register_form_alter` / `hook_form_user_form_alter` → `addFormFields()`.
- `hook_user_delete` → deletes the account's row from `access_code`.
- Integrator hook: `hook_access_code_login_redirect($user)` returns a `Url` to override the
  post-login redirect (see `processLogin`).

## Tokens (`access_code.tokens.inc`)

`hook_token_info` / `hook_tokens` add, under the `user` type, `access-code` and
`access-code-expiration`, resolved from `AccessCodeManager::getAccessCode()`.

## Storage (`access_code.install`)

`access_code_schema()` defines table **`access_code`**: `uid` int, `code` varchar(20)
(**primary key**), `expiration` int (Unix timestamp, `0` = never). `hook_uninstall` clears the
`auto_code_*`, `expiration_default` and `display_input` config keys.
