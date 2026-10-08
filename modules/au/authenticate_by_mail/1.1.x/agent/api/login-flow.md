<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login flow, routes & service overrides

How the passwordless flow is wired, from `authenticate_by_mail.routing.yml`,
`authenticate_by_mail.services.yml`, `authenticate_by_mail.module`, and `src/`.

## Install / enable

`drush en authenticate_by_mail -y`. Only dependency is core `user`. Enabling immediately:
disables password login, disables the password-reset page, and rewrites the login page to the
mailed-link request form. There is no `.install` file and no schema — uninstall simply restores
core behavior.

## Routes

- **`authenticate_by_mail.login`** — path `/authenticate-by-mail/{uid}/{timestamp}/{hash}`,
  `_controller: LoginController::authenticate`, `_access: 'TRUE'`, options `_maintenance_access: TRUE`,
  `no_cache: TRUE`. Access is `TRUE` because the URL itself is the capability (valid `hash` required).
- **`authenticate_by_mail.settings`** — path `/admin/config/people/authenticate-by-mail`,
  `_form: SettingsForm`, `_permission: 'administer authenticate_by_mail settings'`. (That permission is
  never declared by the module — see start.md gotcha.)

### Altered core routes (`src/Routing/RouteSubscriber.php`)

`RouteSubscriber::alterRoutes()` (service `authenticate_by_mail.route_subscriber`, `event_subscriber`):
- `user.login` → form set to `LoginForm`, requirement `_user_is_logged_in: 'FALSE'`, `_maintenance_access: TRUE`.
- `user.pass` (password reset) → requirement `_access: 'FALSE'`, `_maintenance_access: FALSE` (disabled).
- Throws `\RuntimeException` if either core route is missing.

## Password auth is disabled (`user.auth` swap)

`AuthenticateByMailServiceProvider::alter()` (`src/AuthenticateByMailServiceProvider.php`) replaces the
`user.auth` service definition with `Drupal\authenticate_by_mail\FailedAuth`, whose `authenticate($username,
$password)` always returns `FALSE`. Consequence: every password-based check fails site-wide (this is why
HTTP Basic Auth and similar modules are incompatible).

## Request form — `LoginForm` (`src/Form/LoginForm.php`)

- Form id `authenticate_by_mail_login_form`, one required field `name` (username **or** email).
  Cache context `url.query_args` added.
- `validateForm()`:
  1. IP flood check `checkFloodIsAllowedAndRegister('flood_request_ip')` — on fail, generic error, stop.
  2. Validates `name` as a username (`UserName` constraint via typed data) **or** email (`email.validator`).
  3. Resolves the account with an entity query `getQuery('OR')->accessCheck(FALSE)` on `mail` **and** `name`,
     `range(0,1)`.
  4. If the account exists and is active, applies per-user flood `flood_request_user` keyed by uid and, when
     allowed, stashes the user via `setTemporaryValue('user', $user)`.
- `submitForm()`: if a user was stashed, calls `_authenticate_by_mail_notify($user)` and logs the mailing;
  otherwise logs an unknown/inactive-account attempt. **Always** shows the constant status message
  "If %name is a valid account, an email was sent with a one-time login link." and redirects to `<front>` —
  so responses do not distinguish existing from non-existing accounts.

## Link generation & mail (`authenticate_by_mail.module`)

- `_authenticate_by_mail_notify(UserInterface $user)` — sends mail key `login` via `plugin.manager.mail`
  to the account's email; returns success bool.
- `_authenticate_by_mail_url(UserInterface $user, $options)` — builds route `authenticate_by_mail.login`
  with `uid`, `timestamp = time()`, and `hash = user_pass_rehash($user, $now)`; absolute URL, language-aware.
- `_authenticate_by_mail_tokens()` — registers the unsafe token `[user:one-time-login-url]` used in the mail
  body; wired into `authenticate_by_mail_mail()` via the token `callback` option.
- `authenticate_by_mail_mail($key, &$message, $params)` — pulls subject/body from
  `authenticate_by_mail.settings`, runs `\Drupal::token()->replace()` (config-override language set from the
  message langcode), subject rendered through `PlainTextOutput::renderFromHtml()`.

## Link verification — `LoginController::authenticate()` (`src/Controller/LoginController.php`)

Deps: `flood`, `datetime.time`. Loads the `{uid}` user, then in order returns a **redirect** (never a raw
page — avoids leaking the link in referrer headers) if any check fails:

1. Current session already authenticated → error, redirect `<front>`.
2. Target user missing or not active (`isActive()`) → error, redirect `<front>`.
3. Link expired: `getLastLoginTime() && (now - timestamp) > timeout` → error, redirect `user.login`.
   (Not enforced when the target has never logged in.)
4. Any of: target not a real account (`!isAuthenticated()`), `timestamp < lastLoginTime`,
   `timestamp > now`, or `!hash_equals($hash, user_pass_rehash($target_user, $timestamp))` → error,
   redirect `user.login`.

On success: `flood->clear('authenticate_by_mail.flood_request_user', $uid)` then `user_login_finalize()`,
redirect `<front>`. The hash is bound to the specific account (uuid + hashed password + last login), so a
link minted for one account cannot log in as another, and the link stops working once that account next logs
in (last-login advances past the link timestamp). Comparison is timing-safe (`hash_equals`).
