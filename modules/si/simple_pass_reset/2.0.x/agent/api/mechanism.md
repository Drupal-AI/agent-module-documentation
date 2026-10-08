# How the reset flow is rewritten

## 1. Route override — `RouteSubscriber`

`src/Routing/RouteSubscriber.php` (tagged `event_subscriber`) alters the core **`user.reset`**
route:
- `_controller` → `\Drupal\simple_pass_reset\Controller\User::resetPass`
- `_title_callback` → `…\Controller\User::title` ("Choose a new password")
- adds requirement `_simple_pass_reset_access` → `ResetPassAccessCheck::access`

## 2. Access check — `ResetPassAccessCheck`

`src/AccessChecks/ResetPassAccessCheck.php` (service `simple_pass_reset.access_checker`,
tagged `access_check`, `applies_to: _simple_pass_reset_access`). Reproduces core's one-time
login validation: user exists and is active; not blocked by another logged-in user; timestamp
not expired against `user.settings:password_reset_timeout`; `hash_equals()` on
`user_pass_rehash()`. Returns Allowed/Forbidden accordingly.

## 3. Controller — `Controller\User::resetPass`

- If the **Guardian** module guards the account, it falls back to core's
  `UserPasswordResetForm` (guarded accounts keep the standard flow).
- If the current user is already logged in as this uid, it logs them out and restarts the
  reset (session must be fresh).
- Otherwise it returns the **user default edit form** directly (the "choose a new password"
  page) — skipping core's intermediate one-time-login landing page.

## 4. Form alter — `simple_pass_reset_form_user_form_alter()`

Only on the `user.reset` route for anonymous users:
- Sets `user_pass_reset` on the form state; appends `simple_pass_reset_pass_reset_submit`.
- Relabels the submit button to **"Save and log in"**.
- Makes the password field **required** and removes its description.
- Hides all non-essential form elements (picture, timezone, mail, …), keeping only the
  account password area and actions.

## 5. Submit — `simple_pass_reset_pass_reset_submit()`

Loads the user, calls `user_login_finalize()` to log them in, logs the one-time-login notice,
and redirects to `simple_pass_reset.settings:login_redirection` (or the `user.page` route if
empty).

## Ordering

`simple_pass_reset_module_implements_alter()` moves this module's `form_alter` **last** so it
wins over other modules' alterations.
